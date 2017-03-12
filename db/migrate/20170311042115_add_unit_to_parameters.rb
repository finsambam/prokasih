class AddUnitToParameters < ActiveRecord::Migration[5.0]
  def change
  	add_column :parameters, :unit, :string
  end
end
