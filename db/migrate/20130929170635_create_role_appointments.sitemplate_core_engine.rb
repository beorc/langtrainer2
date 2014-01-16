# This migration comes from sitemplate_core_engine (originally 20130726111409)
class CreateRoleAppointments < ActiveRecord::Migration
  def change
    create_table :role_appointments do |t|
      t.references :user
      t.string :role_id
    end

    add_index :role_appointments, [:role_id, :user_id]
  end
end
