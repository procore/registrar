require "rails_helper"

RSpec.describe Registrar::SessionsController, type: :controller do
  routes { Registrar::Engine.routes }

  describe "GET #new" do
    it "renders the 'new' template" do
      get :new

      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it "checks if the email is a procore email" do
      request.env["omniauth.auth"] = {
        info: {
          email: "not_procore@gmail.com"
        }
      }

      post :create

      expect(response).to render_template :new
    end

    context "when it is a valid procore email" do
      before do
        request.env["omniauth.auth"] = {
          info: {
            "email" => "procore@procore.com",
            "first_name" => "Example",
            "last_name" => "User"
          }
        }
      end

      it "calls the user builder with the user hash" do
        expect_any_instance_of(Registrar::ProcoreUserBuilder).to receive(:find_or_create) { Registrar::ProcoreUser.new }

        post :create
      end

      it "signs in the created user" do
        user = Registrar::ProcoreUser.new

        allow_any_instance_of(Registrar::ProcoreUserBuilder).to receive_messages(find_or_create: user)

        expect_any_instance_of(Registrar::SessionsHelper).to receive(:sign_in).with(user)

        post :create
      end

      it "redirects to the root_path" do
        post :create

        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE #destroy" do
    it "signs the current_user out" do
      session[:user_id] = Registrar::ProcoreUser.create(first_name: "Example", last_name: "User", email: "example@user.com").id

      delete :destroy

      expect(session[:user_id]).to be nil
    end

    it "redirects to the new_session_path" do
      delete :destroy

      expect(response).to redirect_to Registrar::Engine.routes.url_helpers.new_sessions_path
    end
  end
end
