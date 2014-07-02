class VideosController < ApplicationController
  def index
    @videos    = Video.all
    @comedies  = Video.comedies
    @dramas    = Video.dramas
    @realities = Video.realities
    @action    = Video.action
    @scifi     = Video.scifi
  end

  def show
    @video = Video.find(params[:id])
  end
end
