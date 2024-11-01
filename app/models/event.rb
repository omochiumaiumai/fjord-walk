# frozen_string_literal: true

class Event < ApplicationRecord
  DAYS_OF_THE_WEEK_COUNT = 7

  FREQUENCY_LIST = [
    ['毎週', 0],
    ['第1', 1],
    ['第2', 2],
    ['第3', 3],
    ['第4', 4]
  ].freeze

  DAY_OF_THE_WEEK_LIST = [
    ['日曜日', 0],
    ['月曜日', 1],
    ['火曜日', 2],
    ['水曜日', 3],
    ['木曜日', 4],
    ['金曜日', 5],
    ['土曜日', 6]
  ].freeze

  has_many :event_participants, dependent: :restrict_with_error
  has_many :users, through: :event_participants
  has_many :event_repeat_rules, dependent: :destroy
  has_many :attendances, dependent: :restrict_with_error
  has_many :talk_themes, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :event_repeat_rules, allow_destroy: true

  scope :active, -> { where(status: 'active') }
  scope :scheduled_on, ->(date) { active.filter { |event| event.scheduled_on?(date) } }

  def all_scheduled_dates(
    from: Date.new(Time.current.year, 1, 1),
    to: Date.new(Time.current.year, 12, 31)
  )
    holidays = HolidayJp.between(from, to).map(&:date)
    (from..to).filter do |date|
      if hold_national_holiday == false && holidays.include?(date)
        false
      else
        date_match_the_rules?(date, event_repeat_rules)
      end
    end
  end

  def next_scheduled_date
    today = Time.zone.today
    all_scheduled_dates.select { |date| date >= today }.min
  end

  def date_match_the_rules?(date, rules)
    rules.any? do |rule|
      if rule.frequency.zero?
        rule.day_of_the_week == date.wday
      else
        rule.frequency == nth_wday(date) && rule.day_of_the_week == date.wday
      end
    end
  end

  def scheduled_on?(date)
    all_scheduled_dates.include?(date)
  end

  def nth_wday(date)
    (date.day + 6) / 7
  end
end
