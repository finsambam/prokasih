class Analytic < ApplicationRecord
  validates :location_id, presence: true
  validates :period, presence: true
  validates :criterium_id, presence: true

  has_many :analytic_parameters, dependent: :destroy 
  has_many :parameters, through: :analytic_parameters

  belongs_to :location

  accepts_nested_attributes_for :analytic_parameters
  accepts_nested_attributes_for :parameters

  def self.in_period(start_date, end_date)
    where(
      'period between :start_date and :end_date',
      :start_date => start_date, :end_date => end_date
    )
  end

  def self.by_river_name_and_period(river_name, period)
    joins(:location).where(locations: {river_name: river_name}, period: period)
  end

  # def self.chart_data(river_name, start_date, end_date, parameter_id)
  #   results = []
  #   analytics = joins(:location).where(locations: {river_name: river_name}).in_period(start_date, end_date)
  #   periods = analytics.map { |a| a.period }.uniq

  #   periods.each do |period|
  #     results << {
  #       period: period,
  #       values: analytics.where(period: period).sort_by{|a| a.location_id}
  #     }
  #   end
  #   results
  # end

end