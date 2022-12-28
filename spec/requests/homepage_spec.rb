require 'rails_helper'

RSpec.describe "Homepages", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET edit' do
    it 'returns 302 code' do
      get '/homepage/edit'
      expect(response).to have_http_status(302)
    end

    it 'returns text' do
      get '/homepage/edit'
      expect(response.body).to eq("<html><body>You are being <a href=\"http://www.example.com/log/sign_in\">redirected</a>.</body></html>")
    end
  end
end
