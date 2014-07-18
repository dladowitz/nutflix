class ReviewsController < ApplicationController
  def create
    video = Video.find(review_params[:video_id])

    Review.create(review_params)
    redirect_to video
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :video_id, :rating, :text)
  end
end
