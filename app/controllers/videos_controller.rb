class VideosController < ApplicationController
  before_filter :require_user

  def index
    @categories = Category.all
  end

  def show
    @video  = Video.find(params.fetch(:id)) # fetch(:id) is the same as [:id]
    @review = Review.new  # for the review form_for method
    @reviews = @video.reviews
  end

  def search
    @videos = Video.search_by_title(params.fetch(:search_term))
  end
end
