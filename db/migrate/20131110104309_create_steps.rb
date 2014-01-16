class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :en
      t.string :en_regexp
      t.string :ru
      t.string :ru_regexp
      t.text :template
    end
  end
end
