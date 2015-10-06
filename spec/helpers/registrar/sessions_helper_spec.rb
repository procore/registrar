require "rails_helper"

RSpec.describe Registrar::SessionsHelper, type: :helper do
  let(:user) do
    User.create!(
      first_name: "Example",
      last_name: "User",
      email: "user@example.com"
    )
  end

  describe "sign_in" do
    it "sets the passed in user's id to session[:user_id]" do
      helper.send(:sign_in, user)

      expect(session[:user_id]).to eq(user.id)
    end

    it "sets current_user = user" do
      helper.send(:sign_in, user)

      expect(helper.send(:current_user)).to eq(user)
    end
  end

  describe "current_user" do
    it "finds the current user by session[:user_id])" do
      session[:user_id] = user.id

      expect(helper.send(:current_user)).to eq(user)
    end
  end
end
