module ResultsHelper
	def analytic_value_class(value, params_id)
		begin
			parameter = Parameter.find(params_id)
			selected_criterium_parameter = @selected_criterium.criterium_parameters.find_by(parameter_id: params_id)
			if parameter.criterium_type == "rentang nilai"
				value.to_f >= selected_criterium_parameter.value.to_f && value.to_f <= selected_criterium_parameter.value2.to_f ? 'black' : 'red'	
			else
				value.to_f > selected_criterium_parameter.value.to_f ? 'red' : 'black'	
			end
		rescue 
			'black'
		end
	end
end
