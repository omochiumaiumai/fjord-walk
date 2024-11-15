# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :set_event

  def create
    @attendance = @event.attendances.new(user: current_user, attended_on: Date.today)
    if @attendance.save
      redirect_to dashboard_path(current_user), notice: '出席登録が完了しました。'
    else
      redirect_to dashboard_path(current_user), alert: '出席登録に失敗しました。'
    end
  end

  def destroy
    @attendance = @event.attendances.find_by(user: current_user)
    if @attendance
      @attendance.destroy
      redirect_to dashboard_path(current_user), notice: '出席を取り消しました。'
    else
      redirect_to dashboard_path(current_user), alert: '出席取り消しに失敗しました。'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
