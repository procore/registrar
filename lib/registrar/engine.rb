module Registrar
  class Engine < ::Rails::Engine
    isolate_namespace Registrar

    require "rubygems"
    require "omniauth"
    require "omniauth-google-oauth2"

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
