class VideosController < ApplicationController
  def index
    # TODO move this back to a helper (not sure why it wasn't working in videos helper)
    @categories_map = { "Comedy" => 1, "Drama" => 2, "Reality" => 3, "Action" => 4, "Sci-Fi" => 5 }
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def search
    @videos = Video.search_by_title(params[:search_term])
  end
end
