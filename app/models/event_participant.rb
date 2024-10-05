# frozen_string_literal: true

class EventParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :event
end
