class AddNativeLanguageIdToUnitAdvances < ActiveRecord::Migration
  def change
    add_reference :unit_advances, :native_language, index: true
  end
end
