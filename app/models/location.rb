class Location < ApplicationRecord
  # validates :river_name, presence: true
  # validates :spot_name, presence: true
  # validates :address, presence: true, if: :coordinate_empty?
  # validates :longitude, presence: true, if: "address.nil?"
  # validates :latitude, presence: true, if: "address.nil?"

  validate :must_be_presents

  has_one :analytic

  RIVERS = ["Sungai Gung Lama", "Sungai Sibelis", "Sungai Kemiri"].freeze
  
  # initialize geocoder
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_validation :reverse_geocode, unless: ->(obj) { obj.address.present? },
    if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }

  scope :by_river_name, ->(name) { where(:river_name => name) }
  
  def get_code_prefix
    case self[:river_name]
    when "Sungai Gung Lama"
      code_pref = "GL"
    when "Sungai Sibelis"
      code_pref = "SB"
    when "Sungai Kemiri"
      code_pref = "KM"
    end
  end

  private

  def coordinate_empty?
    return latitude.blank? && longitude.blank?
  end

  def must_be_presents
    errors[:base] << "Nama sungai tidak boleh kosong" if river_name.blank?
    errors[:base] << "Titik lokasi boleh kosong" if spot_name.blank?
    if address.blank? && !coordinate_empty?
      errors[:base] << "Longitude lokasi boleh kosong" if longitude.blank?
      errors[:base] << "Latitude lokasi boleh kosong" if latitude.blank?  
    elsif coordinate_empty?
      errors[:base] << "Salah satu dari alamat atau koordinat lokasi boleh kosong" if address.blank?  
    end
  end
end
