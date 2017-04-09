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

      attributes_hash = {
        api_id: response['id'],
        sent_to_ocd: true
      }

      snack.update_attributes(attributes_hash)
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

# The API requests in this project are handled through jobs and sidekiq.
# I did this because I don't want to bog down the server making requests
# when it may be busy and this way it can perform them when it likes
# (though in this situation that is pretty unlikely...).
# Additionally sidekiq will repeat any jobs that errored.

# This definitely a design decision that brought up several questions.
# First when should these jobs be ran? Well I have created rake tasks that
# the server can perform at a desired interval, whatever it may be.
# The downside to this is that it won't be instantaneous when a employee
# adds a new snack. For that I could also call the job at that moment
# if need be.

# The other part of the prompt that made me question this was that
# the web service is supposed to provide the user an error page
# when the service is unavailable. However because the user themselves
# are never making / initializing the API request I did not add the
# error message, which again could be a benefit of this approach.
