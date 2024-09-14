# frozen_string_literal: true

class EventParticipant < ApplicationRecord
  belongs_to :users, :events
end
