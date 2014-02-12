class CreateUnitAdvanceSnapshots < ActiveRecord::Migration
  def change
    create_table :unit_advance_snapshots do |t|
      t.references :unit_advance, index: true
      t.integer :steps_passed, default: 0
      t.integer :words_helped, default: 0
      t.integer :steps_helped, default: 0
      t.integer :right_answers, default: 0
      t.integer :wrong_answers, default: 0
      t.date :date
      t.timestamps

      t.index [:unit_advance_id, :date], unique: true
    end
  end
end
