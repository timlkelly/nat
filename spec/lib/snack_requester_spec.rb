require 'rails_helper'

RSpec.describe SnackRequester do
  describe '#request_snacks' do
    # target is a copy of the response from the API
    let(:target) { JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'snack_api_response.json'))) }

    it 'returns json' do
      # Use VCR to limit number of external calls during fetching
      VCR.use_cassette('snack_api_fetch') do
        json_response = SnackRequester.new.request_snacks

        expect(json_response).to eq(target)
      end
    end
  end
end
