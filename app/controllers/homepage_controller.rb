class HomepageController < ApplicationController
  before_action :set_cookie, only: %i[profile edit up]
  def index
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
