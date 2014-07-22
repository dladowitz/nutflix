class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def require_user
    redirect_to signin_path unless current_user
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def is_integer?(string)
    begin
      eval(string).class == Fixnum ? true : false
    rescue
      return false
    end
  end
end
