class Registrar::ApplicationController < ActionController::Base
  include Registrar::SessionsHelper

  protect_from_forgery with: :exception
end
