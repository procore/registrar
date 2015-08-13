require_relative "../../app/services/whitelist.rb"

RSpec.describe Whitelist do
  describe ".all" do
    it "returns a list of whitelisted emails" do
      expect(Whitelist.all.count).to_not eq 0
      expect(Whitelist.all).to include "jeff.frost@gmail.com"
    end
  end
end
