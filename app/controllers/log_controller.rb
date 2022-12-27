# frozen_string_literal: true

# This class for actions and methods in log controller
class LogController < ApplicationController
  before_action :set_params
  before_action :set_cookie, only: :sign_out
  def sign_in
    return unless check

    user = User.find_by(email: @email)
    if user.authenticate(@password)
      session[:current_user_id] = user.id
      cookies[:login] = { value: user.id, expires: (Time.now + 60) } # 1 minute
      redirect_to root_path
    else
      @msg << 'Incorrect password!'
    end
  end

  def sign_up
    user = User.new(email: @email, password: @password,
                    password_confirmation: @password_confirmation, role: 'user')
    if user.valid?
      user.save
      @msg_s = true
    else
      user.errors.objects.map(&:full_message).each { |msg| @msg << msg }
    end
  end

  def sign_out
    session[:current_user_id] = nil
    cookies.delete :login
    redirect_to root_path
  end

  def log
    case @commit
    when 'Sign Up'
      sign_up
    when 'Log In'
      sign_in
    end
  end

  private

  def set_params
    @email = params[:email]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
    @commit = params[:commit]
    @msg = []
    @msg_s = false
  end

  def check
    if User.find_by(email: @email).nil?
      @msg << 'This email is not registered'
      return false
    end
    true
  end
end
