require 'cns_generator'

class Citizen < ApplicationRecord
  include CnsGenerator

  has_one :address
  has_one_attached :photo

  accepts_nested_attributes_for :address

  validates :full_name, :tax_id, :national_health_card, :birthdate, presence: true
  validates :status, inclusion: { in: [true, false] }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_REGEX }

  validate :validate_birthdate, if: -> { birthdate.present? }
  validate :cpf_valid, if: -> { tax_id.present? }
  validate :validate_national_health_card, if: -> { national_health_card.present? }
  validates :phone, format: {
    with: /\A\+?\d{1,3}?[\s-]?\(?\d{2,3}\)?[\s-]?\d{4,5}[\s-]?\d{4}\z/,
    message: 'must include country and area codes in the correct format'
  }

  scope :filter_by_full_name, ->(full_name) { where('full_name ILIKE ?', "%#{full_name}%") }
  scope :filter_by_tax_id, ->(tax_id) { where('tax_id ILIKE ?', "%#{tax_id}%") }
  scope :filter_by_national_health_card, lambda { |national_health_card|
                                           where('national_health_card ILIKE ?', "%#{national_health_card}%")
                                         }
  scope :filter_by_email, ->(email) { where('email ILIKE ?', "%#{email}%") }
  scope :filter_by_birthdate, ->(birthdate) { where(birthdate:) }
  scope :filter_by_phone, ->(phone) { where('phone ILIKE ?', "%#{phone}%") }

  def self.filter(filtering_params)
    results = where(nil)

    filtering_params.each do |key, value|
      results = results.public_send("filter_by_#{key}", value) if value.present?
    end

    results
  end

  private

  def validate_birthdate
    if birthdate > Date.today
      errors.add(:birthdate, "can't be in the future")
      return
    end

    return unless birthdate < 150.years.ago

    errors.add(:birthdate, "can't be more than 150 years ago")
  end

  def cpf_valid
    return if CPF.valid?(tax_id, strict: true)

    errors.add(:tax_id, 'is not a valid CPF')
  end

  def validate_national_health_card
    return if valid_cns_format?(national_health_card) && valid_cns_number?(national_health_card)

    errors.add(:national_health_card, 'is not a valid CNS number')
  end

  def valid_cns_format?(number)
    number.match?(/^\d{15}$/)
  end
end
