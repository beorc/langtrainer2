class AddSpanishToStepMappings < ActiveRecord::Migration
  def change
    change_table :step_mappings do |t|
      t.boolean :from_es, default: true
      t.boolean :to_es, default: true
    end
  end
end
