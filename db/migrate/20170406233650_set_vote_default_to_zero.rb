class SetVoteDefaultToZero < ActiveRecord::Migration[5.0]
  def change
    change_column :snacks, :votes, :integer, null: false, default: 0
  end
end
