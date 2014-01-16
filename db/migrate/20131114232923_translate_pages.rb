class TranslatePages < ActiveRecord::Migration
  def up
    Page.create_translation_table!({
      title: :string,
      short: :text,
      content: :text
    }, {
      migrate_data: true
    })

    remove_column :pages, :title
    remove_column :pages, :short
    remove_column :pages, :content
  end

  def down
    Page.drop_translation_table! :migrate_data => true
  end
end
