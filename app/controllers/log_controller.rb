class LogController < ApplicationController
  before_action :set_params
  def sign_in
    if User.find_by(email: @email).nil?
      @msg  << 'This email is not registered'
      return
    end
    user = User.find_by(email: @email, password: @password)
    if user.nil?
      @msg << 'Incorrect password!'
    else
      if session[:current_user_id] == user.id # Len ...
        @msg << 'User already log in'
        return
      end
      session[:current_user_id] = user.id
    end
  end

  def sign_up
    return unless check
    user = User.new(email: @email, password: @password)
    if user.valid?
      user.save
    else 
      user.errors.objects.map(&:message).each { |msg| @msg << msg }
    end
  end

  def sign_out
  end

  def log
    if @commit == 'Sign Up'
      sign_up
    elsif @commit == 'Log In'
      sign_in
    else
      session[:current_user_id] = 0
    end
  end

  private
  
  def check
    unless User.find_by(email: @email).nil?
      @msg << 'This email is already registered'
      return false
    end
    return true
  end

  def set_params
    @email = params[:email]
    @password = params[:password]
    @commit = params[:commit]
    @msg= []
  end
end
