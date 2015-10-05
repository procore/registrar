require "rails_helper"

RSpec.describe Registrar do
  describe ".configure" do
    it "sets configuration options" do
      Registrar.configure do |config|
        config.google_client_id = "client_id"
        config.google_client_secret = "client_secret"
        config.domain = "example.com"
        config.whitelist += %W(test@example.com)
      end

      expect(Registrar.configuration.google_client_id).to eq "client_id"
      expect(Registrar.configuration.google_client_secret).to eq "client_secret"
      expect(Registrar.configuration.domain).to eq "example.com"
      expect(Registrar.configuration.whitelist).to include "test@example.com"
    end
  end
end
