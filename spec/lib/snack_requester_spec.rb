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

  describe '#send_new_snacks' do
    it 'updates the api_id on the snack' do
      VCR.use_cassette('send_snack_post') do
        snack = FactoryGirl.create(:snack, added_by_employee: true)
        expect(snack.api_id).to_not be_present

        SnackRequester.new.send_new_snacks([snack])

        expect(snack.api_id).to be_present
      end
    end
  end
end
