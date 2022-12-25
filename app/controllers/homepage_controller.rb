class HomepageController < ApplicationController
  before_action :set_cookie
  def index
  end

  def profile
    render partial: 'profile_list'
  end

  def edit
    render partial: 'frame'
  end

  def up
    render partial: 'up_frame'
  end
end
