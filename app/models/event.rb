# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :event_participants, dependent: :restrict_with_error
  has_many :attendances, dependent: :restrict_with_error
  has_many :talk_themes, dependent: :destroy
  belongs_to :users
end
