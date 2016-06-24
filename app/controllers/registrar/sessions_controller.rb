class Registrar::SessionsController < Registrar::ApplicationController
  def new
  end

  def create
    if authorized_email?
      user = User.create_with(user_hash).find_or_create_by(email: email)
      sign_in(user)

      redirect = session[:target] || root_path

      redirect_to redirect
    else
      render :new
    end
  end

  def destroy
    sign_out

    redirect_to registrar.signin_path
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
    EmailChecker.new(email).authorized?
  end
end
