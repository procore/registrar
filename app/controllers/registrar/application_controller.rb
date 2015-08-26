class Registrar::ApplicationController < ActionController::Base
  include Registrar::SessionsHelper
  layout "layouts/registrar"

  protect_from_forgery with: :exception
end
