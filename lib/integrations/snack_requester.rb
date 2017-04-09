class SnackRequester
  include HTTParty
  base_uri 'https://api-snacks.nerderylabs.com/v1'
  API_PATH = "/snacks?ApiKey=#{ENV['SNACK_API_KEY']}"

  def request_snacks
    response = self.class.get(API_PATH)

    JSON.parse(response.body)
  end

  def send_new_snacks(snacks)
    snacks.each do |snack|
      options = {
        body: {
          name: snack.name,
          location: snack.purchase_location,
          lastPurchaseDate: snack.last_purchased_at
        }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      }

      response = self.class.post(API_PATH, options)

      snack.update_attribute(:api_id, response['id'])
      # Need to set the api id because that is how we locate
      # snacks in the database and make sure we aren't making
      # duplicates when we request snacks. See line 4 in Snack
      # Processor
    end
  end

  # Use a separate class to make API requests
  # This helps keep the core of the app clean and controllers
  # shouldn't make requests
end
