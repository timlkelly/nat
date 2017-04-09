class AddFieldsToSnackForPost < ActiveRecord::Migration[5.0]
  def change
    add_column(:snacks, :added_by_employee, :boolean, default: false)
    add_column(:snacks, :sent_to_ocd, :boolean, default: false)
  end
end
