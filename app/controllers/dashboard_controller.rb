# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :set_beginning_of_week
  def show
    @user = User.find(params[:user_id])
    @attendances = user_attendances(@user)
    @attended_events = attended_events(@user)
    @upcoming_attendances = upcoming_attendances(@user)
    @attended_users = attended_users(@upcoming_attendances)
  end

  private

  def user_attendances(user)
    user.attendances.pluck(:attended_on)
  end

  def attended_events(user)
    user.attendances.includes(:event).where.not(attended_on: nil)
  end

  def upcoming_attendances(user)
    user.attendances.includes(:event).where(attended_on: Time.zone.today..)
  end

  def attended_users(upcoming_attendances)
    if upcoming_attendances.any?
      upcoming_attendances.map(&:event).flat_map do |event|
        event.attendances.includes(:user).where(attended_on: Time.zone.today..).map(&:user)
      end.uniq
    else
      []
    end
  end

  private

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end
