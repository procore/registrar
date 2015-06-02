module ProcoreUsers::SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id

    current_user = user
  end

  def signed_in?
    current_user.signed_in?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= ProcoreUser.find_by(id: session[:user_id]) || GuestUser.new
  end
end
