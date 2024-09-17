class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path, notice: "イベントが作成されました"
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time)
  end
end
