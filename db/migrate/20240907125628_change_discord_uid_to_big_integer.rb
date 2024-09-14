class ChangeDiscordUidToBigInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :discord_uid, :bigint
  end
end
