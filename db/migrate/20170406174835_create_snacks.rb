class CreateSnacks < ActiveRecord::Migration[5.0]
  def change
    create_table :snacks do |t|
      t.string :name
      t.text :purchase_location
      t.integer :votes
      t.boolean :suggestion
      t.boolean :optional
      t.integer :times_purchased
      t.date :last_purchased_at

      t.timestamps
    end
  end
end
