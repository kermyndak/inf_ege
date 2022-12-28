require 'rails_helper'

RSpec.describe "Logs", type: :request do
  describe "POST /log" do
    it "returns http success" do
      post "/log/log", xhr: true
      expect(response).to have_http_status(:success)
    end

    it 'returns successfuly registration' do
      post "/log/log/", params: {commit: 'Sign Up', email: 'user@mail.ru', password: 'password', password_confirmation: 'password'}, xhr: true
      expect(response.body).to eq("<turbo-stream action=\"update\" target=\"msg\"><template></template></turbo-stream>\n    <turbo-stream action=\"update\" target=\"msg-s\"><template>Successfuly registration!</template></turbo-stream>\n")
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
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /sign_up" do
    it "returns http success" do
      get "/log/sign_up"
      expect(response).to have_http_status(:success)
    end

    context 'controller tests' do
      it 'test @msg_s' do
        post "/log/log", params: {commit: 'Sign Up', email: 'user@mail.ru', password: 'password', password_confirmation: 'password'}, xhr: true
        expect(assigns(:msg_s)).to be true
      end

      it 'test @msg_s' do
        post '/log/log', params: {commit: 'Sign Up', email: 'user@mail.ru', password: 'password', password_confirmation: 'bad'}, xhr: true
        expect(assigns(:msg_s)).to be false
      end

      it 'test @msg' do
        post "/log/log", params: {commit: 'Sign Up', email: 'user@mail.ru', password: 'password', password_confirmation: 'password'}, xhr: true
        expect(assigns(:msg)).to eq([])
      end

      it 'test @msg' do
        post '/log/log', params: {commit: 'Sign Up', email: 'user@mail.ru', password: 'password', password_confirmation: 'bad'}, xhr: true
        expect(assigns(:msg)).to eq(["Password confirmation doesn't match Password"])
      end

      it 'test @msg' do
        post '/log/log', params: {commit: 'Sign Up', email: 'user', password: 'password', password_confirmation: 'password'}, xhr: true
        expect(assigns(:msg)).to eq(["Email This incorrect email address"])
      end

      it 'test @msg' do
        post '/log/log', params: {commit: 'Sign Up', email: 'user@mail.ru', password: 'pass', password_confirmation: 'pass'}, xhr: true
        expect(assigns(:msg)).to eq(["Password Length password - min 8 symbols"])
      end

      it 'test @msg' do
        post '/log/log', params: {commit: 'Sign Up', email: 'user', password: 'pass', password_confirmation: 'passe'}, xhr: true
        expect(assigns(:msg)).to eq(["Password confirmation doesn't match Password", "Email This incorrect email address", "Password Length password - min 8 symbols"])
      end

      it 'test @msg' do
        post '/log/log', params: {commit: 'Log In', email: 'user', password: 'pass', password_confirmation: 'passe'}, xhr: true
        expect(assigns(:msg)).to eq(["This email is not registered"])
      end
    end
  end
end
