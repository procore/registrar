require "rails_helper"

RSpec.describe Registrar::User do
  describe "validations" do
    it "is invalid without an email address" do
      expect(Registrar::User.create).to_not be_valid
      expect(Registrar::User.create(email: "user@example.com")).to be_valid
    end

    it "must have a unique email address" do
      Registrar::User.create(email: "user@example.com")
      expect(Registrar::User.create(email: "user@example.com")).not_to be_valid
    end
  end

  describe "#full_name" do
    it "returns the user's capitalized first and last names joined by a space" do
      user = Registrar::User.create(email: "user@example.com", first_name: "example", last_name: "user")
      expect(user.full_name).to eq "Example User"
    end

    it "returns the user's email address if they don't have a first or last name set" do
      user = Registrar::User.create(email: "user@example.com")
      expect(user.full_name).to eq "user@example.com"
    end
  end
end
