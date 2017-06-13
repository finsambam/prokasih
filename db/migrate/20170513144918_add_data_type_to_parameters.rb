class AddDataTypeToParameters < ActiveRecord::Migration[5.0]
  def change
    add_column :parameters, :analytic_type, :string
    add_column :parameters, :criterium_type, :string
  end
end
