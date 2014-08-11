class Admin::VideosController < ApplicationController
  include Authenticate
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if Rails.env.test?
      @video.process_large_cover_upload = true
      @video.process_small_cover_upload = true
    end

    @video.save
    redirect_to @video
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :category_id, :large_cover, :small_cover, :video_url)
  end
end

