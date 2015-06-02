$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "procore_users/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "procore_users"
  s.version     = ProcoreUsers::VERSION
  s.authors       = ["Procore Engineering"]
  s.email         = ["dev@procore.com"]
  s.summary       = "A central user registration engine for Procore's internal tools"
  s.description   = ""
  s.homepage      = ""
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "4.2.1"
  s.add_dependency "dotenv-rails"
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-google-oauth2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "bundler"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "rake"
end
