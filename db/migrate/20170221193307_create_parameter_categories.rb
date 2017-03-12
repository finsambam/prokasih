class CreateParameterCategories < ActiveRecord::Migration[5.0]
  def self.up
    create_table :parameter_categories do |t|
    	t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :parameter_categories
  end
end
