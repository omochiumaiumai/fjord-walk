# frozen_string_literal: true

class SessionsController < ApplicationController
  def callback
    auth_info = request.env['omniauth.auth']
    if (user = User.find_or_create_from_discord_info(auth_info))
      reset_session
      log_in user
    end

    redirect_to dashboard_path(current_user.id)
  end

  def failure
    redirect_to root_path
  end
end
