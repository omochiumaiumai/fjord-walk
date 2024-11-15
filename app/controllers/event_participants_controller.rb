# frozen_string_literal: true

class EventParticipantsController < ApplicationController
  before_action :set_event

  def create
    @participant = @event.event_participants.new(user: current_user)
    if @participant.save
      flash[:notice] = t('event.notice.entry_sucsess')
    else
      flash[:alert] = t('event.alert.entry_failure')
    end
    redirect_to event_path(@event)
  end

  def destroy
    @participant = EventParticipant.find_by(event_id: @event.id, user_id: current_user.id)
    if @participant
      @participant.destroy
      flash[:notice] = t('event.notice.entry_cancel')
    else
      flash[:alert] = t('event.alert.entry_cancel_failure')
    end
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
