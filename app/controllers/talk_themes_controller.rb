class TalkThemesController < ApplicationController
  before_action :set_event
  before_action :check_participation, only: [:create]

  def index
    @talk_themes = @event.talk_themes
  end

  def create
    @talk_theme = @event.talk_themes.new(talk_theme_params)
    @talk_theme.user_id = current_user.id
    if @talk_theme.save
      redirect_to event_talk_themes_path(@event), notice: 'トークテーマが追加されました。'
    else
      render :index
    end
  end

  def destroy
    @talk_theme = @event.talk_themes.find(params[:id])
    @talk_theme.destroy
    redirect_to event_talk_themes_path(@event), notice: 'トークテーマが削除されました。'
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def talk_theme_params
    params.require(:talk_theme).permit(:theme)
  end

  def check_participation
    return if @event.event_participants.exists?(user_id: current_user.id)

    redirect_to @event, alert: 'このイベントに参加していないため、トークテーマを登録できません。'
  end
end
