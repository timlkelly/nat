require 'rails_helper'

RSpec.describe SnacksController, type: :controller do
  describe '#index' do
    let(:permanent_snack) { FactoryGirl.create(:snack, optional: false) }
    let(:suggested_snack) { FactoryGirl.create(:snack, optional: true, suggested: true) }

    it 'renders 200 and assigns @snacks' do
      get :index

      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(assigns(:permanent_snacks)).to eq([permanent_snack])
      expect(assigns(:suggested_snacks)).to eq([suggested_snack])
    end
  end

  describe '#new' do
    let(:suggestible_snack) { FactoryGirl.create(:snack, optional: true, suggested: false) }

    it 'renders 200' do
      get :new

      expect(response.status).to eq(200)
      expect(response).to render_template('new')
    end

    it 'assigns suggestable snacks' do
      get :new

      expect(assigns(:suggestible_snacks)).to eq([suggestible_snack])
    end
  end

  describe '#create' do
    let(:snack_attributes) { FactoryGirl.attributes_for(:snack) }

    context 'with valid attributes' do
      it 'saves the new snack' do
        expect {
          post :create, params: { snack: snack_attributes }
        }.to change(Snack, :count).by(1)
      end

      it 'redirects upon successful creation' do
        post :create, params: { snack: snack_attributes }

        expect(response.status).to eq(302)
        expect(response).to redirect_to(snacks_path)
      end

      it 'marks the snack as a suggestion' do
        post :create, params: { snack: snack_attributes }
        snack = Snack.first

        expect(snack.optional).to be_truthy
      end
    end

    context 'invalid attributes' do
      it 'does not save (loctaion)' do
        expect {
          post :create, params: { snack: { name: 'Snack', purchase_location: nil } }
        }.to_not change(Snack, :count)
      end

      it 'does not save (name)' do
        expect {
          post :create, params: { snack: { name: nil, purchase_location: 'gas station' } }
        }.to_not change(Snack, :count)
      end

      it 're-renders the new method' do
        post :create, params: { snack: { name: nil, purchase_location: nil } }

        expect(response.status).to eq(200)
        expect(response).to render_template('new')
        expect(flash[:error]).to be_present
      end
    end

    context 'duplicate suggestion' do
      before(:example) do
        FactoryGirl.create(:snack, name: 'Chips', purchase_location: 'Berkeley Bowl')
      end

      it 'does not save' do
        expect {
          post :create, params: { snack: { name: 'Chips', purchase_location: 'Berkeley Bowl' } }
        }.to_not change(Snack, :count)
      end

      it 're-renders the new method' do
        post :create, params: { snack: { name: 'Chips', purchase_location: 'Berkeley Bowl' } }

        expect(response.status).to eq(200)
        expect(response).to render_template('new')
        expect(flash[:error]).to be_present
      end
    end

    context 'employee has already suggested a snack' do
      it 'does not save' do
        request.cookies['voted'] = true

        expect {
          post :create, params: { snack: snack_attributes }
        }.to_not change(Snack, :count)
        expect(flash[:error]).to be_present
      end
    end
  end

  describe '#already_voted?' do
    before(:example) do
      controller = SnacksController.new
    end

    context 'has voted' do
      it 'returns true' do
        request.cookies['voted'] = true

        expect(controller.instance_eval { already_voted? }).to be_truthy
      end
    end

    context 'has not voted' do
      it 'returns false' do
        request.cookies['voted'] = false

        expect(controller.instance_eval { already_voted? }).to be_falsey
      end
    end
  end
end
