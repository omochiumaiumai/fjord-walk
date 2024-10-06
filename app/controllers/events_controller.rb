# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to events_path, notice: t('event.create_sucsess')
    else
      render :new
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
