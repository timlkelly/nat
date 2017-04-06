require 'rails_helper'

RSpec.describe SnacksController, type: :controller do
  describe 'GET index' do
    let(:snack) { FactoryGirl.create(:snack) }

    it 'renders 200 and assigns @snacks' do
      get :index

      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(assigns(:snacks)).to eq([snack])
    end
  end
end
