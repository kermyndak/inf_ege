require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /profile_page" do
    it "returns http success" do
      get "/profile/profile_page"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin_page" do
    it "returns http success" do
      get "/profile/admin_page"
      expect(response).to have_http_status(:success)
    end
  end

end
