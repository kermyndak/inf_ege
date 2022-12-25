class ApplicationController < ActionController::Base
  def set_cookie
    if cookies[:login]
      if session[:current_user_id]
        cookies[:login] = { value: session[:current_user_id], expires: (Time.now + 600) } # 10 minute
      end
    else
      session[:current_user_id] = nil
      redirect_to '/log/sign_up'
    end
  end
end
