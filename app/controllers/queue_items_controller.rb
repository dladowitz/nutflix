class QueueItemsController < ApplicationController
  before_filter  :require_user

  def index
    if current_user
      @user = current_user
      @queue_items = current_user.queue_items.order("queue_rank ASC")
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

  def update
    if invalid_update_params?
      flash[:danger] = "Not gonna happen mang"
    else
      user_changed_items = items_changed_in_ui
      update_all_queue_items(user_changed_items)
    end

    redirect_to queue_path
  end

  def destroy
    @queue_item = QueueItem.find_by_id params[:id]
    items_in_users_queue = current_user.queue_items

    if @queue_item == nil
      flash[:error] = "That not even an item in anyone's queue."
    elsif items_in_users_queue.include?(@queue_item)
      @queue_item.delete
      items_already_in_queue.each{ |item| item.update_attributes(queue_rank: next_free_rank) }
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

  def get_item_instances(user_changed_items)
    item_instances = []
    user_changed_items.each { |hash| item_instances << hash[:queue_item] }
    item_instances
  end

  def invalid_update_params?
    ranks = []
    params[:queue_items].each do |queue_item|
      item = QueueItem.find_by_id queue_item[:id]

      return true unless item # tests for valid id
      return true unless is_integer?(queue_item[:queue_rank])
      return true unless item.user == current_user # tests to ensure only users queue items are being updated

      ranks << queue_item[:queue_rank]
    end

    # tests for duplicate queue_ranks
    return true unless ranks.length == ranks.uniq.length

    return false
  end

  def is_integer?(string)
    begin
      eval(string).class == Fixnum ? true : false
    rescue
      return false
    end
  end

  def item_rank
    items_already_in_queue.count + 1
  end

  def items_already_in_queue
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
    queue_items = items_already_in_queue
    ranks = queue_items.map(&:queue_rank)
    taken_ranks = ranks.select{|rank| rank if rank < 500}

    queue_items.count.times do |index|
      if taken_ranks.include?(index + 1)
        next
      else
        return index + 1
      end
    end
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

  # this method is getting pretty messy. could use a refactor
  def update_all_queue_items(user_changed_items)
    ordered_items = items_already_in_queue.order(:queue_rank)
    free_up_queue_rankings(ordered_items)

    update_user_changed_items(user_changed_items)

    # need to turn queue item hashes into item instances
    user_changed_item_instances = get_item_instances(user_changed_items)

    # skips anything in user_changed_item_instances
    update_non_user_changed_items(ordered_items, user_changed_item_instances)
  end

  def update_user_changed_items(user_changed_items)
    user_changed_items.each do |item_and_rank|
      item_and_rank[:queue_item].update_attributes(queue_rank: item_and_rank[:queue_rank])
    end
  end

  def update_non_user_changed_items(ordered_items, user_changed_item_instances)
    ordered_items.each_with_index do |item|
      item.update_attributes(queue_rank: next_free_rank) unless user_changed_item_instances.include?(item)
    end
  end

  def video_already_in_queue?(video)
    queue_item = QueueItem.where(user: current_user, video: video).first
    items_already_in_queue.include?(queue_item)
  end
end
