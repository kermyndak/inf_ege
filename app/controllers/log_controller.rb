class LogController < ApplicationController
  before_action :set_params
  def sign_in
    if User.find_by(email: @email).nil?
      @msg  << 'This email is not registered'
      return
    end
    user = User.find_by(email: @email)
    if user.authenticate(@password)
      session[:current_user_id] = user.id
      redirect_to root_path
    else
      @msg << 'Incorrect password!'
    end
  end

  def sign_up
    user = User.new(email: @email, password: @password, 
      password_confirmation: @password_confirmation)
    if user.valid?
      user.save
      @msg_s = true
    else 
      user.errors.objects.map(&:full_message).each { |msg| @msg << msg }
    end
  end

  def sign_out
    session[:current_user_id] = nil
    redirect_to root_path
  end

  def log
    if @commit == 'Sign Up'
      sign_up
    elsif @commit == 'Log In'
      sign_in
    end
  end

  private

  def set_params
    @email = params[:email]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
    @commit = params[:commit]
    @msg= []
    @msg_s = false
  end
end
