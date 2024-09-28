# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:notice] = t('notice.user_name_update')
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return unless @user.nil?

    flash[:alert] = t('alert.user_not_found')
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
