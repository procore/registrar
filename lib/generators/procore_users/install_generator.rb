class ProcoreUsers::InstallGenerator < ::Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  desc "Installs ProcoreUsers."

  def install
    template "initializer.rb", "config/initializers/omniauth.rb"
    copy_file File.expand_path("../../../../config/locales/en.yml", __FILE__), "config/locales/doorkeeper.en.yml"

    route 'resources :sessions, only: [:new, :create]'
    route 'get "/auth/google/callback", to: "sessions#create"'
  end
end
