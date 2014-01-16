class CreateStepBoxMappings < ActiveRecord::Migration
  def change
    create_table :step_box_mappings do |t|
      t.references :box, index: true
      t.references :step, index: true
    end
  end
end
