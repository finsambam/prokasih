class AddCriteriumReferenceToAnalytic < ActiveRecord::Migration[5.0]
  def change
  	add_column :analytics, :criterium_id, :integer
  end
end
