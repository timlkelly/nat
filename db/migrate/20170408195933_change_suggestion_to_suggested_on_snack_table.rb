class ChangeSuggestionToSuggestedOnSnackTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :snacks, :suggestion, :suggested
  end
end
