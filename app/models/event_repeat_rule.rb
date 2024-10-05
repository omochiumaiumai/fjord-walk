# frozen_string_literal: true

class EventRepeatRule < ApplicationRecord
  belongs_to :event

  validates :frequency, presence: true
  validates :day_of_the_week, presence: true
end
