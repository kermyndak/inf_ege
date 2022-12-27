# frozen_string_literal: true

# This class for actions and methods in profile controller
class ProfileController < ApplicationController
  before_action :set_cookie
  before_action :redirect_to_sign_in
  before_action :set_profile, only: :profile_page
  before_action :set_edit, only: :log

  def profile_page
    @balls = @tests.map(&:result).sum
    @level = get_level(@balls)
    @procent = ((@balls - @level[1]) / (@level[2] - @level[1]).to_f * 100).to_i
  end

  def admin_page
    redirect_to root_path if User.find(session[:current_user_id]).role != 'superadmin'
    @users = User.where.not(role: 'superadmin')
  end

  def set_admin
    @user_id = params[:user].to_i
    @user = User.find(@user_id)
    if @user.role == 'user'
      @user.update_column(:role, 'admin')
    else
      @user.update_column(:role, 'user')
    end
    render partial: 'admin'
  end

  def destroy
    @user_id = params[:user].to_i
    User.destroy(@user_id)
    redirect_to '/profile/admin_page'
  end

  def edit; end

  def up
    @id = params[:test].to_i
    render partial: 'up'
  end

  def full_info
    @tests = Test.where(user_id: session[:current_user_id])
    @current = Test.find(params[:test].to_i)
    render partial: 'full_info'
  end

  def tests_info
    @tests = Test.where(user_id: session[:current_user_id])
  end

  def log
    @current.update!(email: @email, password: @password,
                     password_confirmation: @password_confirmation)
  end

  private

  def set_edit
    @email = params[:email]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
    @current = User.find(session[:current_user_id])
    messages
  end

  def set_profile
    @current = User.find(session[:current_user_id])
    @born = @current.created_at
    @born = "#{@born.day}.#{@born.month}.#{@born.year}"
    @tests = Test.where(user_id: session[:current_user_id])
  end

  def messages
    @msg = []
    @msg_s = false
    user = User.new(email: @email, password: @password,
                    password_confirmation: @password_confirmation)
    if user.valid?
      @msg_s = true
    else
      user.errors.objects.map(&:full_message).each { |msg| @msg << msg }
    end
  end

  def get_level(ball)
    case ball
    when (0..10)
      [1, 0, 10]
    when (11..35)
      [2, 11, 35]
    when (36..75)
      [3, 36, 75]
    when (76..120)
      [4, 76, 120]
    else
      [5, 0, 5]
    end
  end
end
