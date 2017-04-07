require 'rails_helper'

RSpec.describe SnacksController, type: :controller do
  describe 'GET index' do
    let(:permanent_snack) { FactoryGirl.create(:snack, optional: false) }
    let(:suggested_snack) { FactoryGirl.create(:snack, optional: true) }

    it 'renders 200 and assigns @snacks' do
      get :index

      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(assigns(:permanent_snacks)).to eq([permanent_snack])
      expect(assigns(:suggested_snacks)).to eq([suggested_snack])
    end
  end
end
