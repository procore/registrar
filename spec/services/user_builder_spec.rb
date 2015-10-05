require "rails_helper"

RSpec.describe Registrar::UserBuilder do
  describe "#find_or_create" do
    it "finds and returns any user that exists with the given email" do
      user = Registrar::User.create!(email: "user@example.com")
      builder = Registrar::UserBuilder.new(
        {
          "email" => "user@example.com",
          "first_name" => "example",
          "last_name" => "user"
        }
      )

      expect(builder.find_or_create).to eq user
    end

    it "creates a new user with the given attributes if a user isn't found" do
      builder = Registrar::UserBuilder.new(
        {
          "email" => "user@example.com",
          "first_name" => "example",
          "last_name" => "user"
        }
      )

      expect { builder.find_or_create }.to change { Registrar::User.count }.by(1)
    end
  end
end
