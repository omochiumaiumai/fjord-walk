# frozen_string_literal: true

class EventParticipant < ApplicationRecord
  belongs_to :users
  belongs_to :events
end
