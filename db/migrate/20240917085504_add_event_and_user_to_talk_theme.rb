class AddEventAndUserToTalkTheme < ActiveRecord::Migration[7.0]
  def change
    add_reference :talk_themes, :event, null: false, foreign_key: true
    add_reference :talk_themes, :user, null: false, foreign_key: true
  end
end
