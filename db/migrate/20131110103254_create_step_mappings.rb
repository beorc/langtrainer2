class CreateStepMappings < ActiveRecord::Migration
  def change
    create_table :step_mappings do |t|
      t.references :unit, index: true
      t.references :step, index: true

      t.integer :position

      t.boolean :from_en, default: true
      t.boolean :to_en, default: true
      t.boolean :from_ru, default: true
      t.boolean :to_ru, default: true

      t.index :position
    end
  end
end
