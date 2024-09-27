class CreateEventRepeatRules < ActiveRecord::Migration[7.0]
  def change
    create_table :event_repeat_rules do |t|
      t.references :event, foreign_key: true
      t.integer :frequency, null: false
      t.integer :day_of_the_week, null: false
      t.timestamps
    end
  end
end
