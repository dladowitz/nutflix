module Authenticate
  def require_user
    unless current_user
      flash[:error] = "You must be logged in to do that"
      redirect_to signin_path
    end
  end

  def require_admin
    if current_user.nil?
      return require_user
    end

    if  !current_user.admin?
      flash[:error] = "Sorry, #{ActionController::Base.helpers.link_to "Permission Denied", "http://cdn.memegenerator.net/instances/400x/24040377.jpg"}".html_safe
      redirect_to videos_path
    end
  end
end

