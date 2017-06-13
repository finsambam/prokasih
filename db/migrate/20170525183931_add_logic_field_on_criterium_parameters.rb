class AddLogicFieldOnCriteriumParameters < ActiveRecord::Migration[5.0]
  def change
    add_column :criterium_parameters, :special_character, :string
    add_column :criterium_parameters, :value2, :string
  end
end
