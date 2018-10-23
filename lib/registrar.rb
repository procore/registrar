require "registrar/engine"

module Registrar
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :google_client_id
    attr_accessor :google_client_secret

    # Domain to validate users against. Anyone who authenticates with an email
    # in this domain will be granted access.
    attr_accessor :domain

    # A list of additional emails to allow access that are outside of the
    # domain specified
    attr_accessor :whitelist

    # URL to render the signin form. Defaults to /signin
    attr_accessor :signin_url

    # URL to signout
    attr_accessor :signout_url

    # Set a url to redirect to after successful signin. Defaults to the root
    # path.
    attr_accessor :after_signin_url

    # Set a url to redirect to after signing out. Defaults to the signin path.
    attr_accessor :after_signout_url

    # Set a user_id cookie on /signin and clear it on /signout. Defaults to false.
    attr_accessor :with_user_cookie

    # Sets your oauth redirect uri
    attr_accessor :redirect_uri

    # Sets subdomain
    attr_accessor :sub_domain

    # Sets the key to use in the session for identifying the user
    attr_accessor :session_key

    # Sets the class to use for session management
    attr_accessor :session_manager_class

    def initialize
      @whitelist = []
      @after_signin_url = "/"
      @signin_url = "/signin"
      @signout_url = "/signout"
      @with_user_cookie = false
      @redirect_uri = nil
      @sub_domain = nil
      @session_key = :user_id
      @session_manager_class = Registrar::SessionManager
    end
  end
end
