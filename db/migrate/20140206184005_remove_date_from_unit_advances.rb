class RemoveDateFromUnitAdvances < ActiveRecord::Migration
  def change
    remove_column :unit_advances, :date
  end
end
