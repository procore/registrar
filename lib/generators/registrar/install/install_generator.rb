require 'rails/generators/base'
require 'rails/generators/active_record'

module Registrar
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_registrar_initializer
        initializer "registrar.rb" do
          <<-RUBY.strip_heredoc
            Registrar.configure do |config|
              config.google_client_id = ENV.fetch("GOOGLE_CLIENT_ID", nil)
              config.google_client_secret = ENV.fetch("GOOGLE_CLIENT_SECRET", nil)
              config.domain = "your_gmail_domain"
              config.whitelist += []
            end
          RUBY
        end
      end

      def include_sessions_helper
        inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\n" do
          <<-RUBY.strip_heredoc.indent(2)
            include Registrar::SessionsHelper
            helper_method :current_user\n
          RUBY
        end
      end

      def mount_engine
        inject_into_file "config/routes.rb", after: "Rails.application.routes.draw do\n" do
          <<-RUBY.strip_heredoc.indent(2)
            mount Registrar::Engine, at: '/'

          RUBY
        end
      end

      def add_or_create_user
        unless File.exist? "app/models/user.rb"
          create_file "app/models/user.rb",
            <<-'RUBY'.strip_heredoc
            class User < ActiveRecord::Base
              validates :email, presence: true, uniqueness: true

              def full_name
                "#{first_name.try(:capitalize)} #{last_name.try(:capitalize)}".presence || email
              end
            end
          RUBY
        end
      end

      def install_and_run_migrations
        unless ActiveRecord::Base.connection.table_exists?(:users)
          rake "registrar:install:migrations"
          rake "db:migrate"
        end
      end
    end
  end
end
