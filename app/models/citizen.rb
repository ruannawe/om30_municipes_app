class Citizen < ApplicationRecord
  has_one :address

  validates :full_name, :tax_id, :national_health_card, :email, :birthdate, :phone, :status, presence: true

  scope :filter_by_full_name, -> (full_name) { where("full_name ILIKE ?", "%#{full_name}%") }
  scope :filter_by_tax_id, -> (tax_id) { where("tax_id ILIKE ?", "%#{tax_id}%") }
  scope :filter_by_tax_id, -> (national_health_card) { where("national_health_card ILIKE ?", "%#{national_health_card}%") }
  scope :filter_by_tax_id, -> (email) { where("email ILIKE ?", "%#{email}%") }
  scope :filter_by_birthdate, -> (birthdate) { where(birthdate: birthdate) }
  scope :filter_by_tax_id, -> (phone) { where("phone ILIKE ?", "%#{phone}%") }

  def self.filter(filtering_params)
    results = where(nil)

    filtering_params.each do |key, value|
      results = results.public_send("filter_by_#{key}", value) if value.present?
    end

    results
  end
end
