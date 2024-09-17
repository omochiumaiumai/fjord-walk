class AddEventAndUserToEventParticipants < ActiveRecord::Migration[7.0]
  def change
    add_reference :event_participants, :event, null: false, foreign_key: true
    add_reference :event_participants, :user, null: false, foreign_key: true
  end
end
