class ProfileController < ApplicationController
  before_action :set_params
  def profile_page
  end

  def admin_page
  end

  private

  def set_params
    @current = User.find(session[:current_user_id])
    @born = @current.created_at
    @born = "#{@born.day}.#{@born.month}.#{@born.year}"
    @tests = Test.where(user_id: session[:current_user_id])
    @count = @tests.size
    @balls = @tests.map(&:result).sum
    @level = get_level(@balls)
    @procent = ((@balls - @level[1]) / (@level[2] - @level[1]).to_f * 100).to_i
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
