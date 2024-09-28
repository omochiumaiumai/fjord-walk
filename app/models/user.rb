# frozen_string_literal: true

class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :talk_themes, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :event_participants, dependent: :destroy

  def self.find_or_create_from_discord_info(auth_info)
    User.find_or_create_by(discord_uid: auth_info.uid) do |user|
      user.name = auth_info.info.name
      user.avatar_url = auth_info.info.image
    end
  end

  def attendance_days_count
    attendances.select('DATE(attended_on)').distinct.count
  end

  def last_attendance_date
    attendances.order(attended_on: :desc).pick(:attended_on)
  end
end
