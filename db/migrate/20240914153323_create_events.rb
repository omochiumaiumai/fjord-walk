class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :status, null:false, default: 'active'
      t.boolean :deletion_requested, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
