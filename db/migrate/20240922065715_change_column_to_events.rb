class ChangeColumnToEvents < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:events, :hold_national_holiday, from: nil, to: false)
  end
end
