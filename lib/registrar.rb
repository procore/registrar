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
    attr_accessor :google_client_id, :google_client_secret, :domain, :whitelist

    def initialize
      @whitelist = []
    end
  end
end
