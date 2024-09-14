# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end
end
