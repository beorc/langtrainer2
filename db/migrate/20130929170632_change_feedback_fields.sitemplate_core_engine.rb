# This migration comes from sitemplate_core_engine (originally 20130705144706)
class ChangeFeedbackFields < ActiveRecord::Migration
  def up
    remove_columns :feedbacks, :name, :phone
    rename_column :feedbacks, :email, :contact_info
  end

  def down
    add_column :feedbacks, :name, :string
    add_column :feedbacks, :phone, :string
    rename_column :feedbacks, :contact_info, :email
  end
end
