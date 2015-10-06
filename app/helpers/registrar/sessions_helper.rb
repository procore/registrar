module Registrar::SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id

    current_user = user
  end

  def signed_in?
    current_user.present?
  end

  def sign_out
    session[:user_id] = nil
    session[:target] = nil
    current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= ::User.find_by(id: session[:user_id])
  end

  private

  def require_signed_in_user
    unless signed_in?
      session[:target] = request.fullpath
      redirect_to registrar.signin_path
    end
  end
end
