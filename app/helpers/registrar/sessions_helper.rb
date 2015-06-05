module Registrar::SessionsHelper
  # set before_action :authorize to authenticate

  def sign_in(user)
    session[:user_id] = user.id

    current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= Registrar::ProcoreUser.find_by(id: session[:user_id])
  end

  private

  def authorize
    unless current_user
      redirect_to new_session_path
    end
  end
end
