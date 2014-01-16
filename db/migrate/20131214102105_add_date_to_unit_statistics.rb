class AddDateToUnitStatistics < ActiveRecord::Migration
  def change
    add_column :unit_statistics, :date, :date
    add_index :unit_statistics, :date
  end
end
