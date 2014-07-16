class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    if current_user
      @user = current_user
      @queue_items = QueueItem.where(user_id: @user.id).order("queue_rank ASC")
    else
      flash[:warning] = "Whatcho talkin' bout Willis? You need to be logged in to view your Queue."
      redirect_to signin_path
    end
  end

  def create
    user =  User.find params[:user_id]
    video = Video.find params[:video_id]
    items_already_in_queue = QueueItem.where(user: user)
    rank = items_already_in_queue.count + 1

    @queue_item = QueueItem.new(queue_rank: rank, user_id: params[:user_id], video_id: params[:video_id])

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
end
