# frozen_string_literal: true

class TalkTheme < ApplicationRecord
  belongs_to :users
  belongs_to :events
end
