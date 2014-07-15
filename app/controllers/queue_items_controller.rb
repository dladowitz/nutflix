class QueueItemsController < ApplicationController
  def index
    if current_user
      @user = current_user
      @queue_items = QueueItem.where(user_id: @user.id).order("queue_rank ASC")
    else
      flash[:warning] = "Whatcho talkin' bout Willis? You need to be logged in to view your Queue."
      redirect_to signin_path
    end
  end
end
