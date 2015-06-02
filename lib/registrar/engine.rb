module Registrar
  class Engine < ::Rails::Engine
    isolate_namespace Registrar

    require "rubygems"
    require "omniauth"
    require "omniauth-google-oauth2"
  end
end
