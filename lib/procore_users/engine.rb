module ProcoreUsers
  class Engine < ::Rails::Engine
    isolate_namespace ProcoreUsers

    require "rubygems"
    require "omniauth"
    require "omniauth-google-oauth2"
  end
end
