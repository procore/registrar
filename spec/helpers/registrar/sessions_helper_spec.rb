require "rails_helper"

class SpecialSessionsManager
  class << self
    def session_id(user)
      [user.first_name, user.last_name, user.email].join(",")
    end

    def find_by_session_id(session_id)
      first_name, last_name, email = session_id.split(",")
      User.find_by(
        first_name: first_name,
        last_name: last_name,
        email: email,
      )
    end
  end
end

RSpec.describe Registrar::SessionsHelper, type: :helper do
  let(:user) do
    User.create!(
      first_name: "Example",
      last_name: "User",
      email: "user@example.com"
    )
  end

  after do
    Registrar.configuration = Registrar::Configuration.new
  end

  describe "sign_in" do
    it "sets the passed in user's id to session[:user_id]" do
      helper.send(:sign_in, user)

      expect(session[:user_id]).to eq(user.id)
    end

    it "respects custom session keys" do
      Registrar.configure { |config| config.session_key = :special }
      helper.send(:sign_in, user)

      expect(session[:special]).to eq(user.id)
      expect(helper.send(:current_user)).to eq(user)
    end

    it "respects custom session managers" do
      Registrar.configure { |config| config.session_manager_class = SpecialSessionsManager }
      helper.send(:sign_in, user)

      expect(helper.send(:current_user)).to eq(user)
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
