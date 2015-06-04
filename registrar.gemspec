$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "registrar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "registrar"
  s.version     = Registrar::VERSION
  s.authors       = ["Procore Engineering"]
  s.email         = ["dev@procore.com"]
  s.summary       = "A central user registration engine for Procore's internal tools"
  s.description   = ""
  s.homepage      = ""
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "4.2.1"
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-google-oauth2"

  s.add_development_dependency "bundler"
  s.add_development_dependency "pg"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec-rails"
end
