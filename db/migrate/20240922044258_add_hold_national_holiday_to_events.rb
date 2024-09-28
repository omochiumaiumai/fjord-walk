class AddHoldNationalHolidayToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :hold_national_holiday, :boolean, null: false
  end
end
