# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :set_beginning_of_week
  def show
    @user = User.find(params[:user_id])
    @attendances = @user.attendances.pluck(:attended_on)
    @attended_events = @user.attendances.includes(:event).where.not(attended_on: nil)
    @attended_users = @attended_events.map(&:event).flat_map do |event|
      event.attendances.includes(:user).where.not(attended_on: nil).map(&:user)
    end.uniq
  end

  private

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end
