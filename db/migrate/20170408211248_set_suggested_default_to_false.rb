class SetSuggestedDefaultToFalse < ActiveRecord::Migration[5.0]
  def change
    change_column :snacks, :suggested, :boolean, default: false
  end
end
