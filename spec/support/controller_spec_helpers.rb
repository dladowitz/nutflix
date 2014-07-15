module ControllerSpecHelpers

  def login_as(account)
    session[:user_id] = account.id
  end

end
