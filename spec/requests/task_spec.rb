require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /first_part" do
    it "returns http success" do
      get "/task/first_part"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /second_part" do
    it "returns http success" do
      get "/task/second_part"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /exam" do
    it "returns http success" do
      get "/task/exam"
      expect(response).to have_http_status(:success)
    end
  end

end
