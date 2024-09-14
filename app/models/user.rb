# frozen_string_literal: true

class User < ApplicationRecord
  def self.find_or_create_from_discord_info(auth_info)
    User.find_or_create_by(discord_uid: auth_info.uid) do |user|
      user.name = auth_info.info.name
      user.avatar_url = auth_info.info.image
    end
  end
end
