class CriteriumParameter < ApplicationRecord
  belongs_to :criterium
  belongs_to :parameter

  def self.chart_data(parameter, criterium, location_count)
  	params = where(criterium_id: criterium, parameter_id: parameter)
    result = {
  		period: "BM #{params.first.parameter.name}",
  		values: []
  	}
    (1..location_count).each do |loc|
    	result[:values] << params.first.value
    end

    return result
  end
end
