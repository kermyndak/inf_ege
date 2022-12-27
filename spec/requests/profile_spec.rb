require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /profile_page" do
    it "returns http success" do
      get "/profile/profile_page"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /admin_page" do
    it "returns http success" do
      get "/profile/admin_page"
      expect(response).to have_http_status(302)
    end
  end

  describe 'Redirect without session activate' do
    it 'admin_page' do
      get '/profile/admin_page'
      expect(response).to redirect_to('/log/sign_in')
    end

    it 'edit' do
      get '/profile/edit'
      expect(response).to redirect_to('/log/sign_in')
    end

    it 'profile_page' do
      get '/profile/profile_page'
      expect(response).to redirect_to('/log/sign_in')
    end

    it 'tests_info' do
      get '/profile/tests_info'
      expect(response).to redirect_to('/log/sign_in')
    end
  end
end
