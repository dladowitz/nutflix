class Admin::VideosController < ApplicationController
  include Authenticate
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(video_params)
    redirect_to @video
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :category_id)
  end
end

