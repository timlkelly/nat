class SnackProcessor
  def create(snacks_json)
    snacks_json.each do |snack|
      s = Snack.find_or_create_by(api_id: snack['id'])
      s.update_attributes(create_snack_hash(snack))
      s.save
    end
  end

  def create_snack_hash(snack)
    {
      api_id: snack['id'],
      last_purchased_at: Date.strptime(snack['lastPurchaseDate'], '%m/%d/%Y'),
      name: snack['name'],
      optional: snack['optional'],
      purchase_location: snack['purchaseLocations'],
      times_purchased: snack['purchaseCount']
    }
  end
end
