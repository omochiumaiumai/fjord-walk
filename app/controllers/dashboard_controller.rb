# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :set_beginning_of_week
  def show
    @user = User.find(params[:user_id])
    @attendances = @user.attendances.pluck(:attended_on)
    @attended_events = @user.attendances.includes(:event).where.not(attended_on: nil)
    @upcoming_attendances = @user.attendances.includes(:event).where(attended_on: Time.zone.today..)

    @attended_users = if @upcoming_attendances.any?
                        @upcoming_attendances.map(&:event).flat_map do |event|
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
