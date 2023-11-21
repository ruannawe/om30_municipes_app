class Address < ApplicationRecord
  belongs_to :citizen

  validates :zip_code, :street, :neighborhood, :city, :state, presence: true

  scope :filter_by_zip_code, ->(zip_code) { where('zip_code ILIKE ?', "%#{zip_code}%") }
  scope :filter_by_street, ->(street) { where('street ILIKE ?', "%#{street}%") }
  scope :filter_by_neighborhood, ->(neighborhood) { where('neighborhood ILIKE ?', "%#{neighborhood}%") }
  scope :filter_by_city, ->(city) { where('city ILIKE ?', "%#{city}%") }
  scope :filter_by_state, ->(state) { where('state ILIKE ?', "%#{state}%") }
  scope :filter_by_ibge_code, ->(ibge_code) { where('ibge_code ILIKE ?', "%#{ibge_code}%") }

  def self.filter(filtering_params)
    results = where(nil)

    filtering_params.each do |key, value|
      results = results.public_send("filter_by_#{key}", value) if value.present?
    end

    results
  end
end
