# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @event_organizer = User.find(@event.user_id)
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.event_participants.new(user: current_user)
    if @event.save
      redirect_to events_path, notice: t('event.create_sucsess')
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: 'イベントが更新されました。'
    else
      render :edit
    end
  end

  def request_deletion
    @event = Event.find(params[:id])
    if @event.update(deletion_requested: true)
      flash[:notice] = '削除申請を受け付けました。確認次第、削除対応を行います。ありがとうございました。'
      redirect_to events_path
    else
      redirect_to @event, alert: '削除申請に失敗しました。'
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :title,
      :description,
      :start_time,
      :end_time,
      event_repeat_rules_attributes: %i[id event_id frequency day_of_the_week _destroy]
    )
  end
end
