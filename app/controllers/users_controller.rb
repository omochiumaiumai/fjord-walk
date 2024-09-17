# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find_by(params[:user_id])
  end

  def edit
    @user = User.find_by(params[:user_id])
  end
end
