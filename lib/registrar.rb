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

    def initialize
      @whitelist = []
      @after_signin_url = "/"
      @signin_url = "/signin"
      @signout_url = "/signout"
      @with_user_cookie = false
    end
  end
end
