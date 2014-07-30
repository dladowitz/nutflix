module ControllerSpecHelpers
  def login_user(account = nil)
    session[:user_id] = ( account || users(:james_bond)).id
  end

  def logout_user
    session[:user_id] = nil
  end

  def current_user
    User.find session[:user_id]
  end
end
