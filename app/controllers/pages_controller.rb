class PagesController < ApplicationController
  def home
    redirect_to videos_path if current_user
  end
end
