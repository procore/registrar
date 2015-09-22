require_relative "../../app/services/email_checker.rb"

RSpec.describe EmailChecker do
  describe "#authorized?" do
    it "authorizes procore email addresses" do
      expect(EmailChecker.new("user@procore.com").authorized?).to be true
    end

    it "authorizes whitelisted emails" do
      expect(EmailChecker.new(EmailChecker::WHITELISTED_EMAILS.first).authorized?).to be true
    end

    it "doesn't authorize non-procore and not whitelisted emails" do
      expect(EmailChecker.new("user@other_domain.com").authorized?).to be false
      expect(EmailChecker.new("user@fakeprocore.com").authorized?).to be false
      expect(EmailChecker.new("user@procore.com.fake").authorized?).to be false
    end
  end
end
