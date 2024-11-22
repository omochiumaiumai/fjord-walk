# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = Event.order(created_at: :desc)
  end

  def show
    @event = Event.find(params[:id])
    @event_organizer = User.find(@event.user_id)
  end

  def new
    @event = Event.new
    @event.event_repeat_rules.build
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
      event_create_failure
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: t('event.update_sucsess')
    else
      render :edit
    end
  end

  def request_deletion
    @event = Event.find(params[:id])
    if @event.update(deletion_requested: true)
      flash[:notice] = t('event.request_deletion')
      redirect_to events_path
    else
      redirect_to @event, alert: t('event.request_deletion_failure')
    end
  end

  private

  def event_create_failure
    flash[:alert] = @event.errors.full_messages.to_sentence
    redirect_to new_event_path
  end

  def event_params
    params.require(:event).permit(
      :title,
      :description,
      :start_time,
      :end_time,
      :hold_national_holiday,
      event_repeat_rules_attributes: %i[id event_id frequency day_of_the_week _destroy]
    )
  end
end
