class HomepageController < ApplicationController
  before_action :set_cookie
  before_action :redirect_to_sign_up, only: %i[profile edit up]
  def index
    @users = User.where(role: nil)
    @users = @users.map { |user| [user, Test.where(user_id: user.id).map(&:result).sum] }
  end

  def profile
    @role = User.find(session[:current_user_id]).role
    render partial: 'profile_list'
  end

  def edit
    render partial: 'frame'
  end

  def up
    render partial: 'up_frame'
  end
end
