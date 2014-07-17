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
    items_already_in_queue = current_user.queue_items
    rank = items_already_in_queue.count + 1

    @queue_item = QueueItem.new(queue_rank: rank, user_id: current_user.id, video_id: video.id)

    if @queue_item.save
      redirect_to queue_path
    else
      if items_already_in_queue.where(video_id: video.id).any?
        flash[:danger] = "Chill, this video is already in your queue."
      else
        flash[:danger] = "Something has gone wrong. Hide yo kids, hide yo wife."
      end

      redirect_to video_path Video.find params[:video_id]
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
end
