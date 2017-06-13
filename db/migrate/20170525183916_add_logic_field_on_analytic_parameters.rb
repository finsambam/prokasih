class AddLogicFieldOnAnalyticParameters < ActiveRecord::Migration[5.0]
  def change
    add_column :analytic_parameters, :special_character, :string
  end
end
