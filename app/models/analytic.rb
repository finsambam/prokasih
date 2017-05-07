class Analytic < ApplicationRecord
  # validates :location_id, presence: true
  # validates :period, presence: true
  # validates :criterium_id, presence: true
  validate :must_be_presents

  has_many :analytic_parameters, dependent: :destroy 
  has_many :parameters, through: :analytic_parameters

  belongs_to :location

  accepts_nested_attributes_for :analytic_parameters
  accepts_nested_attributes_for :parameters

  def must_be_presents
    errors[:base] << "Lokasi tidak boleh kosong" if location_id.blank?
    errors[:base] << "Periode tidak boleh kosong" if period.blank?
    errors[:base] << "Kriteria tidak boleh kosong" if criterium_id.blank?
  end
  
  def self.in_period(start_date, end_date)
    where(
      'period between :start_date and :end_date',
      :start_date => start_date, :end_date => end_date
    )
  end

  def self.by_river_name_and_period(river_name, period)
    joins(:location).where(locations: {river_name: river_name}, period: period)
  end


end