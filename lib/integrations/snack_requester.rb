class SnackRequester
  include HTTParty
  base_uri 'https://api-snacks.nerderylabs.com/v1'

  def request_snacks
    response = self.class.get("/snacks?ApiKey=#{ENV['SNACK_API_KEY']}")

    JSON.parse(response.body)
  end
end
