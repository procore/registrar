require "rails_helper"

RSpec.describe Registrar::SessionsController, type: :controller do
  routes { Registrar::Engine.routes }

  before do
    Registrar.configuration.domain = "example.com"
  end

  describe "GET #new" do
    it "renders the 'new' template" do
      get :new

      expect(response).to  have_http_status(200)
    end
  end

  describe "POST #create" do
    it "checks if the email is in the specified domain" do
      request.env["omniauth.auth"] = {
        info: {
          email: "not_example@gmail.com"
        }
      }

      post :create

      expect(response).to  have_http_status(200)
    end

    context "when it is a valid email" do
      before do
        request.env["omniauth.auth"] = {
          info: {
            "email" => "user@example.com",
            "first_name" => "Example",
            "last_name" => "User"
          }
        }
      end

      it "creates new user from the user hash" do
        expect do
          post :create
        end.to change(User, :count).by(1)

        user = User.last
        expect(user.email).to eq "user@example.com"
        expect(user.first_name).to eq "Example"
        expect(user.last_name).to eq "User"
      end

      it "redirects to the default redirect_path" do
        post :create

        expect(response).to redirect_to root_path
      end

      context "custom redirect_url" do
        it "will use any custom redirect_urls" do
          Registrar.configuration.after_signin_url = "/something_custom"

          post :create

          expect(response).to redirect_to "/something_custom"
        end
      end
    end
  end

  describe "DELETE #destroy" do
    it "signs the current_user out" do
      session[:user_id] = User.create!(first_name: "Example", last_name: "User", email: "example@user.com").id

      delete :destroy

      expect(session[:user_id]).to be nil
    end

    it "redirects to the new_session_path by default" do
      delete :destroy

      expect(response).to redirect_to Registrar::Engine.routes.url_helpers.signin_path
    end

    it "will use a custom after sign out url" do
      Registrar.configuration.after_signout_url = "/custom_signout"
      delete :destroy

      # Reset State
      Registrar.configuration.after_signout_url = nil

      expect(response).to redirect_to "/custom_signout"
    end
  end
end
