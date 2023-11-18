require 'rails_helper'

RSpec.describe Citizen, type: :model do
  describe 'validations' do
    before do
      @citizen = Citizen.new(
        full_name: 'John Doe',
        tax_id: '123456789',
        national_health_card: '987654321',
        email: 'johndoe@example.com',
        birthdate: Date.new(1980, 1, 1),
        phone: '1234567890',
        status: true
      )
    end

    it 'is valid with all attributes' do
      expect(@citizen).to be_valid
    end

    it 'is invalid without a full_name' do
      @citizen.full_name = nil
      expect(@citizen).to_not be_valid
      expect(@citizen.errors[:full_name]).to include("can't be blank")
    end

    it 'is invalid without a tax_id' do
      @citizen.tax_id = nil
      expect(@citizen).to_not be_valid
      expect(@citizen.errors[:tax_id]).to include("can't be blank")
    end

    it 'is invalid without a national_health_card' do
      @citizen.national_health_card = nil
      expect(@citizen).to_not be_valid
      expect(@citizen.errors[:national_health_card]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      @citizen.email = nil
      expect(@citizen).to_not be_valid
      expect(@citizen.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without a birthdate' do
      @citizen.birthdate = nil
      expect(@citizen).to_not be_valid
      expect(@citizen.errors[:birthdate]).to include("can't be blank")
    end

    it 'is invalid without a phone' do
      @citizen.phone = nil
      expect(@citizen).to_not be_valid
      expect(@citizen.errors[:phone]).to include("can't be blank")
    end

    it 'is valid with a false status' do
      @citizen.status = false
      expect(@citizen).to be_valid
    end

    it 'is valid with a true status' do
      @citizen.status = true
      expect(@citizen).to be_valid
    end
  end

  describe 'scopes' do
    before do
      @citizen1 = Citizen.create!(
        full_name: 'Alice Smith',
        tax_id: '111111111',
        national_health_card: '222222222',
        email: 'alice@example.com',
        birthdate: Date.new(1990, 1, 1),
        phone: '1234567890',
        status: true
      )
      @citizen2 = Citizen.create!(
        full_name: 'Bob Jones',
        tax_id: '333333333',
        national_health_card: '444444444',
        email: 'bob@example.com',
        birthdate: Date.new(1995, 1, 1),
        phone: '0987654321',
        status: false
      )
    end

    it 'filters by full_name' do
      expect(Citizen.filter_by_full_name('Alice')).to include(@citizen1)
      expect(Citizen.filter_by_full_name('Alice')).to_not include(@citizen2)
    end

    it 'filters by tax_id' do
      expect(Citizen.filter_by_tax_id('111111111')).to include(@citizen1)
      expect(Citizen.filter_by_tax_id('111111111')).to_not include(@citizen2)
    end

    it 'filters by national_health_card' do
      expect(Citizen.filter_by_national_health_card('222222222')).to include(@citizen1)
      expect(Citizen.filter_by_national_health_card('222222222')).to_not include(@citizen2)
    end

    it 'filters by email' do
      expect(Citizen.filter_by_email('alice@example.com')).to include(@citizen1)
      expect(Citizen.filter_by_email('alice@example.com')).to_not include(@citizen2)
    end

    it 'filters by birthdate' do
      expect(Citizen.filter_by_birthdate(Date.new(1990, 1, 1))).to include(@citizen1)
      expect(Citizen.filter_by_birthdate(Date.new(1990, 1, 1))).to_not include(@citizen2)
    end

    it 'filters by phone' do
      expect(Citizen.filter_by_phone('1234567890')).to include(@citizen1)
      expect(Citizen.filter_by_phone('1234567890')).to_not include(@citizen2)
    end
  end
end
