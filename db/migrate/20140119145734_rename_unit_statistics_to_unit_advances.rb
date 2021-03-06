class RenameUnitStatisticsToUnitAdvances < ActiveRecord::Migration
  def change
    rename_table :unit_statistics, :unit_advances

    add_column :unit_advances, :session_token, :string
    add_column :unit_advances, :steps, :text
    add_column :unit_advances, :current_step, :integer, default: 0
    add_column :unit_advances, :revised, :boolean, default: false
    add_column :unit_advances, :revised_steps_number, :integer, default: 0

    add_index :unit_advances, :session_token, unique: true
    add_index :unit_advances, :revised
  end
end
