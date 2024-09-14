class CreateTalkThemes < ActiveRecord::Migration[7.0]
  def change
    create_table :talk_themes do |t|
      t.string :theme, null: false
      t.timestamps
    end
  end
end
