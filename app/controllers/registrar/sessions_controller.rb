class Registrar::SessionsController < Registrar::ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    if authorized_email?
      user = Registrar::ProcoreUserBuilder.new(user_hash).find_or_create
      sign_in(user)

      flash[:success] = "Logged In"
      redirect = if session[:target]
                   session[:target]
                 else
                   root_path
                 end

      redirect_to redirect
    else
      render :new
    end
  end

  def destroy
    sign_out

    redirect_to Registrar::Engine.routes.url_helpers.new_sessions_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"].with_indifferent_access
  end

  def user_hash
    auth_hash[:info].slice("first_name", "last_name", "email")
  end

  def email
    auth_hash[:info][:email]
  end

  def authorized_email?
    procore_email || whitelisted_email
  end

  def procore_email
    email.split("@").last.include?("procore")
  end

  def whitelisted_email
    Whitelist.all.include?(email)
  end
end
