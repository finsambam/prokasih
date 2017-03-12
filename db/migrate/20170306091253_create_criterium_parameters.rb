class CreateCriteriumParameters < ActiveRecord::Migration[5.0]
  def self.up
    create_table :criterium_parameters do |t|
      t.references :criterium, :parameter
      t.string :value
      
      t.timestamps
    end
  end

  def self.down
    drop_table :criterium_parameters
  end
end
