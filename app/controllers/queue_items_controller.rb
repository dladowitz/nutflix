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

  def destroy
    @queue_item = QueueItem.find_by_id params[:id]
    items_in_users_queue = current_user.queue_items

    if @queue_item == nil
      flash[:error] = "That not even an item in anyone's queue."
      redirect_to queue_path
    elsif items_in_users_queue.include?(@queue_item)
      @queue_item.delete
      flash[:notice] = "Goodbye video!"
      redirect_to queue_path
    else
      flash[:error] = "Whoa, hold on partna'. That video isn't in your queue"
      redirect_to queue_path
    end
  end

  private

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
