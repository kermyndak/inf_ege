class HomepageController < ApplicationController
  before_action :set_cookie
  def index
  end

  def edit
    render partial: 'frame'
  end
end
