# frozen_string_literal: true

class TalkTheme < ApplicationRecord
  belongs_to :user
  belongs_to :event
end
