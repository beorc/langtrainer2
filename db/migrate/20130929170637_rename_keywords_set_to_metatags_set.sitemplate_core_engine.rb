# This migration comes from sitemplate_core_engine (originally 20130904080753)
class RenameKeywordsSetToMetatagsSet < ActiveRecord::Migration
  def change
    rename_table 'keywords_sets', 'sitemplate_core_metatags_sets'
    add_column 'sitemplate_core_metatags_sets', 'description', :text
  end
end
