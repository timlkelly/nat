class SnackRequester
  include HTTParty
  base_uri 'https://api-snacks.nerderylabs.com/v1'

  def request_snacks
    response = self.class.get("/snacks?ApiKey=#{ENV['SNACK_API_KEY']}")

    JSON.parse(response.body)
  end

  # Use a separate class to make API requests
  # This helps keep the core of the app clean and controllers
  # shouldn't make requests
end
