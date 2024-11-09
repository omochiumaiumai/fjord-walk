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

  validates :title, presence: true
  validates :description, presence: true
  validate :event_time_conflict
  validate :duration_within_one_hour

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

  def repeat_rules
    event_repeat_rules.map do |rule|
      holding_frequency = FREQUENCY_LIST.find { |frequency| frequency[1] == rule.frequency }[0]
      holding_day_of_the_week = DAY_OF_THE_WEEK_LIST.find do |day_of_the_week|
        day_of_the_week[1] == rule.day_of_the_week
      end[0]
      holding_frequency + holding_day_of_the_week
    end.join('、')
  end

  private

  def duration_within_one_hour
    return unless start_time && end_time
    return unless (end_time - start_time) > 1.hour

    errors.add(:base, 'イベントの開催時間は1時間以内に設定してください。')
  end

  def event_time_conflict
    event_repeat_rules.each do |rule|
      start_time_only = start_time.seconds_since_midnight
      end_time_only = end_time.seconds_since_midnight

      conflicting_events = Event.joins(:event_repeat_rules)
                                .where.not(id:)
                                .where(status: 'active')
                                .where(event_repeat_rules: { day_of_the_week: rule.day_of_the_week })
                                .where(
                                  'EXTRACT(EPOCH FROM events.start_time::time) < ? AND EXTRACT(EPOCH FROM events.end_time::time) > ? OR EXTRACT(EPOCH FROM events.start_time::time) >= ? AND EXTRACT(EPOCH FROM events.start_time::time) < ?',
                                  end_time_only, start_time_only, start_time_only, end_time_only
                                )

      next unless conflicting_events.exists?

      conflicting_titles = conflicting_events.pluck(:title).join(', ')
      errors.add(:base, "登録しようとした時間は「#{conflicting_titles}」が開催中です。こちらのイベントに参加するか、別の時間を選択してください。")
      break
    end
  end
end
