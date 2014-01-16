class AddLocalizedTemplatesToSteps < ActiveRecord::Migration
  def change
    change_table :steps do |t|
      t.text :ru_template
      t.text :en_template
      t.text :es_template
    end
    rename_column :steps, :template, :shared_template
  end
end
