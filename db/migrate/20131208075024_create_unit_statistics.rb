class CreateUnitStatistics < ActiveRecord::Migration
  def change
    create_table :unit_statistics do |t|
      t.references :user, index: true, null: false
      t.references :unit, index: true, null: false

      t.integer :language_id, null: false

      t.integer :steps_passed, default: 0
      t.integer :words_helped, default: 0
      t.integer :steps_helped, default: 0
      t.integer :right_answers, default: 0
      t.integer :wrong_answers, default: 0

      t.timestamps
    end

    add_index :unit_statistics, [:user_id, :unit_id, :language_id], unique: true
  end
end
