require "rails_helper"

RSpec.describe EmailChecker do
  describe "#require_signed_in_user" do
    before do
      Registrar.configuration.domain = "example.com"
    end

    it "authorizes email addresses from the configured domain" do
      expect(EmailChecker.new("user@example.com").authorized?).to be true
    end

    it "authorizes whitelisted emails" do
      Registrar.configuration.whitelist += ["user@other-domain.com"]
      expect(EmailChecker.new("user@other-domain.com").authorized?).to be true
    end

    it "doesn't authorize non-domain and not whitelisted emails" do
      expect(EmailChecker.new("user@other_example.com").authorized?).to be false
      expect(EmailChecker.new("user@fakeexample.com").authorized?).to be false
      expect(EmailChecker.new("user@example.com.fake").authorized?).to be false
    end
  end
end
