class QueueItemsController < ApplicationController
  include Authenticate

  before_filter  :require_user

  def index
    if current_user
      @user = current_user
      @queue_items = current_user.queue_items
    else
      flash[:warning] = "Whatcho talkin' bout Willis? You need to be logged in to view your Queue."
      redirect_to signin_path
    end
  end

  def create
    video = Video.find params[:video_id]

    if queue_video(video)
      redirect_to queue_path
    else
      redirect_to video_path video
    end
  end

  # note that the underlying code is more complex than the solution video
  # I choose to allow users to change just one or two positions in the queue and
  # have the rest of the items update accordingly.
  def update
    if params[:queue_items].nil?
      flash[:danger] = " Nothing to update, but you already knew that."
    elsif invalid_update_params?
      flash[:danger] = "Not gonna happen mang"
    else
      user_changed_items_and_rank = items_changed_in_ui
      update_all_queue_items(user_changed_items_and_rank)
      update_ratings
    end

    redirect_to queue_path
  end

  def destroy
    @queue_item = QueueItem.find_by_id params[:id]

    if @queue_item == nil
      flash[:error] = "That not even an item in anyone's queue."
    elsif current_users_queue.include?(@queue_item)
      @queue_item.delete
      normalize_queue
      flash[:warning] = "Goodbye video!"
    else
      flash[:error] = "Whoa, hold on partna'. That video isn't in your queue"
    end

    redirect_to queue_path
  end

  private

  def free_up_queue_rankings(ordered_items)
    ordered_items.each_with_index {|item, index| item.update_attributes(queue_rank: 500 + index)}
  end

  # I really hate having to do this just to find out if there are 3 queue ranks with the same value

  def invalid_rankings?
    ranks = []
    params[:queue_items].each{ |qi| ranks << qi[:queue_rank] }

    rank_count = Hash.new(0)
    ranks.each { |rank| rank_count[rank] += 1 }

    rank_count.each{ |rank, count| return true if count >= 3 }

    return false
  end

  def invalid_update_params?
    params[:queue_items].each do |queue_item|
      item = QueueItem.find_by_id queue_item[:id]
      return true unless item # tests for valid id
      return true unless is_integer?(queue_item[:queue_rank])
      return true unless item.user == current_user # tests to ensure only users queue items are being updated
    end
    return true if invalid_rankings?

    return false
  end

  def item_rank
    current_users_queue.count + 1
  end

  def current_users_queue
    current_user.queue_items
  end

  # returns queue_items where the queue rank was changed in the UI
  def items_changed_in_ui
    items_to_change = []

    params[:queue_items].each do |queue_item|
      item = QueueItem.find(queue_item[:id])

      if item.queue_rank != queue_item[:queue_rank].to_i
        items_to_change << { queue_item: item, queue_rank: queue_item[:queue_rank] }
      end
    end

    items_to_change
  end

  def next_free_rank
    ranks = current_users_queue.map(&:queue_rank)
    taken_ranks = ranks.select{|rank| rank if rank < 500}

    current_users_queue.count.times do |index|
      if taken_ranks.include?(index + 1)
        next
      else
        return index + 1
      end
    end
  end

  # remove any empty spaces in the continuity of queue ranks for a users queue
  def normalize_queue
    current_users_queue.each_with_index{ |item, index| item.update_attributes(queue_rank: index + 1) }
  end

  def queue_video(video)
    @queue_item = QueueItem.new(queue_rank: item_rank, user_id: current_user.id, video_id: video.id)

    if @queue_item.save
      return true
    else
      if video_already_in_queue?(video)
        flash[:danger] = "Chill, this video is already in your queue."
      else
        flash[:danger] = "Something has gone wrong. Hide yo kids, hide yo wife."
      end

      return false
    end
  end

  # this method is getting pretty messy under the hood. could use a refactor
  def update_all_queue_items(user_changed_items_and_rank)
    free_up_queue_rankings(current_users_queue)
    update_user_changed_items(user_changed_items_and_rank)

    # skips anything in user_changed_item_instances
    update_user_unchanged_items(current_users_queue, user_changed_items_and_rank)
  end

  def update_user_changed_items(user_changed_items_and_rank)
    user_changed_items_and_rank.each do |item_and_rank|
      item_and_rank[:queue_item].update_attributes(queue_rank: item_and_rank[:queue_rank])
    end
  end

  def update_user_unchanged_items(current_users_queue, user_changed_items_and_rank)
    user_changed_items = []
    user_changed_items_and_rank.each { |hash| user_changed_items << hash[:queue_item] }

    current_users_queue.each_with_index do |item|
      item.update_attributes(queue_rank: next_free_rank) unless user_changed_items.include?(item)
    end
  end

  def update_ratings
    params[:queue_items].each do |queue_item|  #could dry this up as its similiar to items_changed_in_ui
      if /[1-5]/ =~ queue_item[:rating]
        item = QueueItem.find(queue_item[:id])

        item.rating = queue_item[:rating].to_i
      end
    end
  end

  def video_already_in_queue?(video)
    queue_item = QueueItem.where(user: current_user, video: video).first
    current_users_queue.include?(queue_item)
  end
end
