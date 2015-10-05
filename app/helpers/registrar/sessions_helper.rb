module Registrar::SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id

    current_user = user
  end

  def signed_in?
    session[:user_id].present?
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
    @current_user ||= Registrar::User.find_by(id: session[:user_id]) || Registrar::GuestUser.new
  end

  private

  def authorize
    unless current_user.is_a?(Registrar::User)
      session[:target] = request.fullpath
      redirect_to Registrar::Engine.routes.url_helpers.new_sessions_path
    end
  end
end
