class AnalyticParameter < ApplicationRecord
  belongs_to :analytic
  belongs_to :parameter

  scope :by_parameter_id, ->(id) { where(:parameter_id => name) }

  def self.chart_data(river_name, start_date, end_date, parameter_id)
  	joins(:analytic => :location).where(locations: {river_name: river_name}, parameter_id: parameter_id).where(
      'analytics.period between :start_date and :end_date',
      :start_date => start_date, :end_date => end_date
    )
  end
end
