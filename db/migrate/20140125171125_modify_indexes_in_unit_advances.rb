class ModifyIndexesInUnitAdvances < ActiveRecord::Migration
  def change
    change_column :unit_advances, :user_id, :integer, null: true
    remove_index :unit_advances, :session_token
    add_index :unit_advances, :session_token
  end
end
