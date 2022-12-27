require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /first_part" do
    it "returns http success" do
      get "/task/first_part"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /second_part" do
    it "returns http success" do
      get "/task/second_part"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /exam" do
    it "returns http success" do
      get "/task/exam"
      expect(response).to have_http_status(302)
    end
  end

  describe 'Redirect without session activate' do
    it 'task' do
      get '/task/task', params: { number: 1 }
      expect(response).to redirect_to('/log/sign_in')
    end

    it 'exam' do
      get '/task/exam'
      expect(response).to redirect_to('/log/sign_in')
    end

    it 'first_part' do
      get '/task/first_part'
      expect(response).to redirect_to('/log/sign_in')
    end

    it 'second_part' do
      get '/task/second_part'
      expect(response).to redirect_to('/log/sign_in')
    end

    it 'result' do
      get '/task/result', params: {answer: ''}
      expect(response).to redirect_to('/log/sign_in')
    end
  end
end
