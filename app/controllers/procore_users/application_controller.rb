module ProcoreUsers
  class ApplicationController < ActionController::Base
    include SessionsHelper

    protect_from_forgery with: :exception

    before_action :authorize

    private

    def authorize
      unless signed_in?
        redirect_to signin_path
      end
    end
  end
end
