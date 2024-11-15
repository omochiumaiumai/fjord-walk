# frozen_string_literal: true

class EventParticipantsController < ApplicationController
  before_action :set_event

  def create
    @participant = @event.event_participants.new(user: current_user)
    if @participant.save
      flash[:notice] = 'イベントへの参加登録が完了しました。'
    else
      flash[:alert] = '参加登録に失敗しました。'
    end
    redirect_to event_path(@event)
  end

  def destroy
    @participant = EventParticipant.find_by(event_id: @event.id, user_id: current_user.id)
    if @participant
      @participant.destroy
      flash[:notice] = 'イベントへの参加を取り消しました。'
    else
      flash[:alert] = 'イベントへの参加取り消しに失敗しました。'
    end
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
