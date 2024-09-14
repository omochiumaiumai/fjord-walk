# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :event_participants, :attendances, :talk_themes, dependent: :restrict_with_error
  belongs_to :users
end
