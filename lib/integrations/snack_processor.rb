class SnackProcessor
  def create(snacks_json)
    snacks_json.each do |snack|
      Snack.create(create_snack_hash(snack))
    end
  end

  def create_snack_hash(snack)
    {
      name: snack['name'],
      purchase_location: snack['purchaseLocations'],
      votes: 0,
      suggestion: false,
      optional: snack['optional'],
      times_purchased: snack['purchaseCount'],
      last_purchased_at: snack ['lastPurchaseDate'],
      api_id: snack['id']
    }
  end
end
