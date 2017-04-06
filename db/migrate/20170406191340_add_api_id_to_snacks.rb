class AddApiIdToSnacks < ActiveRecord::Migration[5.0]
  def change
    add_column :snacks, :api_id, :integer
  end
end
