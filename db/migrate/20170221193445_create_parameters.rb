class CreateParameters < ActiveRecord::Migration[5.0]
  def self.up
    create_table :parameters do |t|
    	t.string :name
    	t.string :parameter_category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :parameters
  end
end
