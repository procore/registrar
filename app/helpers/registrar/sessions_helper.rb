module Registrar::SessionsHelper
  def sign_in_path
    path = "/auth/google"

    if Registrar.configuration&.state
      "#{path}?state=#{Registrar.configuration.state}"
    else
      path
    end
  end

  def sign_in(user)
    session[session_key] = session_manager_class.session_id(user)
    cookies.encrypted[session_key] = session_manager_class.session_id(user) if with_user_cookie?

    current_user = user
  end

  def signed_in?
    current_user.present?
  end

  def sign_out
    session[session_key] = nil
    session[:target] = nil
    cookies.encrypted[session_key] = nil if with_user_cookie?
    current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= session_manager_class.find_by_session_id(session[session_key])
  end

  private

  def require_signed_in_user
    unless signed_in?
      session[:target] = request.fullpath
      redirect_to registrar.signin_path
    end
  end

  def with_user_cookie?
    @_with_user_cookie ||= Registrar.configuration.with_user_cookie
  end

  def session_manager_class
    Registrar.configuration.session_manager_class
  end

  def session_key
    Registrar.configuration.session_key
  end
end
