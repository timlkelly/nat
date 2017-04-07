require 'rails_helper'

RSpec.describe SnackProcessor do
  let(:snack_api_fixture) { JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'snack_api_response.json'))) }
  let(:single_snack_fixture) { JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'single_snack.json'))) }
  let(:instance) { SnackProcessor.new }

  describe '#create' do
    it 'adds new snacks to local db' do
      instance.create(snack_api_fixture)

      expect(Snack.count).to eq(7)
    end

    it 'does not create duplicate entries' do
      Snack.create(
        'api_id': 1000,
        'name': 'Ramen',
        'optional': false,
        'purchase_location': 'Whole Foods',
        'times_purchased': 1,
        'last_purchased_at': '2/22/2017'
      )
      instance.create(snack_api_fixture)

      expect(Snack.count).to eq(7)
    end
  end

  describe '#create_snack_hash' do
    it 'returns hash ready for the db' do
      target = {
        name: 'Ramen',
        purchase_location: 'Whole Foods',
        optional: false,
        times_purchased: 1,
        last_purchased_at: Date.strptime('2/22/2017', '%m/%d/%Y'),
        api_id: 1000
      }

      expect(instance.create_snack_hash(single_snack_fixture)).to eq(target)
    end
  end
end
