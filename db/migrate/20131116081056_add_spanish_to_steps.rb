class AddSpanishToSteps < ActiveRecord::Migration
  def change
    change_table :steps do |t|
      t.string :es
      t.string :es_regexp
    end
  end
end
