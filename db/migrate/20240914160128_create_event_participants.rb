class CreateEventParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :event_participants do |t|
      t.timestamps
    end
  end
end
