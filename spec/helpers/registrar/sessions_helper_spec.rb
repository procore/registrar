require "rails_helper"

RSpec.describe Registrar::SessionsHelper, type: :helper do
  let(:user) { Registrar::ProcoreUser.create(first_name: "Example", last_name: "User", email: "user@example.com") }

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

    it "returns a GuestUser if no user can be found" do
      expect(helper.send(:current_user)).to be_a Registrar::GuestUser
    end
  end
end
