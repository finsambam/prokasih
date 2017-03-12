class CreateLocations < ActiveRecord::Migration[5.0]
  def self.up
    create_table :locations do |t|
      t.string :code
      t.string :river_name
      t.string :spot_name
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
