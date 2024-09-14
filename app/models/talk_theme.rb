# frozen_string_literal: true

class TalkTheme < ApplicationRecord
  belongs_to :users, :events
end
