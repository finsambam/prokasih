module ResultsHelper
	def analytic_value_class(value, params_id)
		begin
			value < @selected_criterium.criterium_parameters.find_by(parameter_id: params_id).value ? 'red' : 'black'
		rescue 
			'black'
		end
	end
end
