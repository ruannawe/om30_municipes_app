require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:citizen) { create(:citizen) }

  describe 'validations' do
    let(:address) { build(:address, citizen: citizen) }

    it 'is valid with valid attributes' do
      expect(address).to be_valid
    end

    it 'is not valid without a zip code' do
      address.zip_code = nil
      expect(address).to_not be_valid
    end

    it 'is not valid without a street' do
      address.street = nil
      expect(address).to_not be_valid
    end

    it 'is not valid without a neighborhood' do
      address.neighborhood = nil
      expect(address).to_not be_valid
    end

    it 'is not valid without a city' do
      address.city = nil
      expect(address).to_not be_valid
    end

    it 'is not valid without a state' do
      address.state = nil
      expect(address).to_not be_valid
    end

    it 'is not valid without a citizen' do
      address.citizen = nil
      expect(address).to_not be_valid
    end
  end

  describe 'scopes' do
    let!(:address1) { create(:address, zip_code: '12345', street: 'Main St', neighborhood: 'Downtown', city: 'Metropolis', state: 'State1', citizen: citizen) }
    let!(:address2) { create(:address, zip_code: '67890', street: 'Second St', neighborhood: 'Uptown', city: 'Gotham', state: 'State2', citizen: citizen) }

    it 'filters by zip_code' do
      expect(Address.filter_by_zip_code('12345')).to include(address1)
      expect(Address.filter_by_zip_code('12345')).to_not include(address2)
    end

    it 'filters by street' do
      expect(Address.filter_by_street('Main')).to include(address1)
      expect(Address.filter_by_street('Main')).to_not include(address2)
    end

    it 'filters by neighborhood' do
      expect(Address.filter_by_neighborhood('Downtown')).to include(address1)
      expect(Address.filter_by_neighborhood('Downtown')).to_not include(address2)
    end

    it 'filters by city' do
      expect(Address.filter_by_city('Metropolis')).to include(address1)
      expect(Address.filter_by_city('Metropolis')).to_not include(address2)
    end

    it 'filters by state' do
      expect(Address.filter_by_state('State1')).to include(address1)
      expect(Address.filter_by_state('State1')).to_not include(address2)
    end

    it 'filters by ibge_code' do
      address1.update!(ibge_code: '11111')
      address2.update!(ibge_code: '22222')
      expect(Address.filter_by_ibge_code('11111')).to include(address1)
      expect(Address.filter_by_ibge_code('11111')).to_not include(address2)
    end
  end
end
