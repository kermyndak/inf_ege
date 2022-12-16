require 'rails_helper'

RSpec.describe "Logs", type: :request do
  describe "GET /log" do
    it "returns http success" do
      get "/log/log"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sign_in" do
    it "returns http success" do
      get "/log/sign_in"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sign_out" do
    it "returns http success" do
      get "/log/sign_out"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sign_up" do
    it "returns http success" do
      get "/log/sign_up"
      expect(response).to have_http_status(:success)
    end
  end

end
