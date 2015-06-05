class Registrar::SessionsController < Registrar::ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    if procore_email?
      user = Registrar::ProcoreUserBuilder.new(user_hash).find_or_create
      sign_in(user)

      flash[:succes] = "Logged In"
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

  def procore_email?
    email.split("@").last.include?("procore")
  end
end
