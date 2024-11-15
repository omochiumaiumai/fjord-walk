# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :set_event

  def create
    @attendance = @event.attendances.new(user: current_user, attended_on: Time.zone.today)
    if @attendance.save
      redirect_to dashboard_path(current_user), notice: t('notice.attendance.create_success')
    else
      redirect_to dashboard_path(current_user), alert: t('alert.attendance.create_failure')
    end
  end

  def destroy
    @attendance = @event.attendances.find_by(user: current_user)
    if @attendance
      @attendance.destroy
      redirect_to dashboard_path(current_user), notice: t('notice.attendance.destroy_success')
    else
      redirect_to dashboard_path(current_user), alert: t('alert.attendance.destroy_failure')
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
