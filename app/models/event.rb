# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :event_participants, dependent: :estrict_with_errordes
  has_many :attendances, dependent: :estrict_with_errordes
  has_many :talk_themes, dependent: :destroy
  belongs_to :users
end
