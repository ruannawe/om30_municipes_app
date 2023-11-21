# spec/controllers/citizens_controller_spec.rb
require 'rails_helper'

RSpec.describe CitizensController, type: :controller do
  describe 'GET #index' do
    it 'assigns @citizens and renders the index template' do
      citizen = create(:citizen)
      get :index
      expect(assigns(:citizens)).to eq([citizen])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Citizen to @citizen' do
      get :new
      expect(assigns(:citizen)).to be_a_new(Citizen)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested citizen to @citizen' do
      citizen = create(:citizen)
      get :edit, params: { id: citizen.id }
      expect(assigns(:citizen)).to eq(citizen)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new citizen with address' do
        address_attributes = attributes_for(:address)
        citizen_params = attributes_for(:citizen).merge(address_attributes: address_attributes)

        expect {
          post :create, params: { citizen: citizen_params }
        }.to change(Citizen, :count).by(1)
      end

      it 'redirects to the index' do
        address_attributes = attributes_for(:address)
        citizen_params = attributes_for(:citizen).merge(address_attributes: address_attributes)

        post :create, params: { citizen: citizen_params }
        expect(response).to redirect_to(citizens_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new citizen' do
        address_attributes = attributes_for(:address)
        citizen_params = attributes_for(:citizen, full_name: nil).merge(address_attributes: address_attributes)

        expect {
          post :create, params: { citizen: citizen_params }
        }.to_not change(Citizen, :count)
      end

      it 're-renders the new method' do
        address_attributes = attributes_for(:address)
        citizen_params = attributes_for(:citizen, full_name: nil).merge(address_attributes: address_attributes)

        post :create, params: { citizen: citizen_params }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @citizen = create(:citizen)
    end

    context 'with valid attributes' do
      it 'locates the requested @citizen' do
        put :update, params: { id: @citizen, citizen: attributes_for(:citizen) }
        expect(assigns(:citizen)).to eq(@citizen)
      end

      it 'changes @citizen attributes' do
        put :update, params: { id: @citizen, citizen: attributes_for(:citizen, full_name: 'New Name') }
        @citizen.reload
        expect(@citizen.full_name).to eq('New Name')
      end

      it 'redirects to the updated citizen' do
        put :update, params: { id: @citizen, citizen: attributes_for(:citizen) }
        expect(response).to redirect_to(citizens_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not change the citizen attributes' do
        put :update, params: { id: @citizen, citizen: attributes_for(:citizen, full_name: nil) }
        expect(@citizen.full_name).to_not eq(nil)
      end

      it 're-renders the edit method' do
        put :update, params: { id: @citizen, citizen: attributes_for(:citizen, full_name: nil) }, format: :html
        expect(response).to render_template(:edit)
      end
    end
  end
end
