# This migration comes from sitemplate_core_engine (originally 20130109072321)
class CreateKeywordsSets < ActiveRecord::Migration
  def change
    create_table :keywords_sets do |t|
      t.text :keywords
      t.references :owner, polymorphic: true
    end

    add_index :keywords_sets, [:owner_id, :owner_type]
  end
end
