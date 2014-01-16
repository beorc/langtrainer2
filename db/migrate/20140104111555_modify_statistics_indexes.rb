class ModifyStatisticsIndexes < ActiveRecord::Migration
  def change
    remove_index :unit_statistics, [:user_id, :unit_id, :language_id]
  end
end
