class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.references :user, index: true
      t.references :course, index: true
      t.integer :number
      t.index :number
    end
  end
end
