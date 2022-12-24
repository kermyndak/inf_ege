class ApplicationController < ActionController::Base
  def set_cookie
    if cookies[:login]
      if session[:current_user_id]
        cookies[:login] = { value: session[:current_user_id], expires: (Time.now + 60) } # 1 minute
      end
    else
      session[:current_user_id] = nil
    end
  end
end
