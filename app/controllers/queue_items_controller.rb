class QueueItemsController < ApplicationController
  before_filter :require_user

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
    @queue_items = current_user.queue_items
    @queue_items.each {|i| p "#{i.video_title} #{i.queue_rank}"}
    puts "-----------------------"

    if params[:changing_items].count == 1
      puts "One item changing"
      # id   = params[:changing_items].first[:id]
      # rank = params[:changing_items].first[:queue_rank]
      #
      # single_item_update(id, rank)

      multi_item_update(params[:changing_items])

    elsif params[:changing_items].count == 2
      puts "Two items changing"
      # rank_options = {
      #   first_id:   params[:changing_items].first[:id],
      #   first_rank: params[:changing_items].first[:queue_rank],
      #
      #   second_id:   params[:changing_items].second[:id],
      #   second_rank: params[:changing_items].second[:queue_rank],
      # }
      # double_item_update(rank_options)

      multi_item_update(params[:changing_items])
      
    elsif params[:changing_items].count > 2
      puts "Multiple items changing"

      multi_item_update(params[:changing_items])
    end


    puts "-----------------------"
    @queue_items = current_user.queue_items
    @queue_items.each {|i| p "#{i.video_title} #{i.queue_rank}"}

    redirect_to queue_path
  end

  def destroy
    @queue_item = QueueItem.find_by_id params[:id]
    items_in_users_queue = current_user.queue_items

    if @queue_item == nil
      flash[:error] = "That not even an item in anyone's queue."
      redirect_to queue_path
    elsif items_in_users_queue.include?(@queue_item)
      @queue_item.delete
      flash[:warning] = "Goodbye video!"
      redirect_to queue_path
    else
      flash[:error] = "Whoa, hold on partna'. That video isn't in your queue"
      redirect_to queue_path
    end
  end

  private

  def single_item_update(id, rank)
    QueueItem.transaction do
      queue_items = current_user.queue_items
      ordered_items = queue_items.order(:queue_rank)
      ordered_items.each_with_index {|item, index| item.update_attributes(queue_rank: 500 + index)}

      item_to_change = QueueItem.find(id)
      item_to_change.update_attributes(queue_rank: rank)

      ordered_items.each_with_index do |item|
        item.update_attributes(queue_rank: next_free_rank) unless item == item_to_change
      end
    end
  end

  def double_item_update(rank_options)
    QueueItem.transaction do
      queue_items = current_user.queue_items
      ordered_items = queue_items.order(:queue_rank) ### refactor to a scope
      ordered_items.each_with_index {|item, index| item.update_attributes(queue_rank: 500 + index)}  ### refactor to a method

      first_item_to_change  = QueueItem.find(rank_options[:first_id])
      second_item_to_change = QueueItem.find(rank_options[:second_id])

      first_item_to_change.update_attributes(queue_rank: rank_options[:first_rank])
      puts "first_item_to_change updated to #{first_item_to_change.queue_rank}"

      second_item_to_change.update_attributes(queue_rank: rank_options[:second_rank])
      puts "second_item_to_change updated to #{second_item_to_change.queue_rank}"

      items_to_change = [first_item_to_change, second_item_to_change]


      ordered_items.each_with_index do |item|
        item.update_attributes(queue_rank: next_free_rank) unless items_to_change.include?(item)
      end
    end
  end

  def multi_item_update(rank_options_array)
    queue_items = current_user.queue_items
    ordered_items = queue_items.order(:queue_rank) ### refactor to a scope
    ordered_items.each_with_index {|item, index| item.update_attributes(queue_rank: 500 + index)}  ### refactor to a method

    # update all items and collect
    items_to_change = []
    rank_options_array.each do |queue_item|
      item = QueueItem.find(queue_item[:id])
      item.update_attributes(queue_rank: queue_item[:queue_rank])
      items_to_change << item
      puts "items to change: #{items_to_change}"
    end

    ordered_items.each_with_index do |item|
      item.update_attributes(queue_rank: next_free_rank) unless items_to_change.include?(item)
    end
  end

  def next_free_rank
    queue_items = QueueItem.where(user: current_user)
    ranks = queue_items.map(&:queue_rank)
    taken_ranks = ranks.select{|rank| rank if rank < 500}
    p "taken ranks: #{taken_ranks}"

    queue_items.count.times do |index|
      if taken_ranks.include?(index + 1)
        p "#{index + 1} is NOT free"
      else
        p "#{index + 1} IS free"
        return index + 1
      end
    end
  end

  def items_already_in_queue
    current_user.queue_items
  end

  def item_rank
    items_already_in_queue.count + 1
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

  def video_already_in_queue?(video)
    queue_item = QueueItem.where(user: current_user, video: video).first
    items_already_in_queue.include?(queue_item)
  end
end
