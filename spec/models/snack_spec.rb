require 'rails_helper'

RSpec.describe Snack, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:purchase_location) }
    it { should validate_uniqueness_of(:name) }
  end
end
