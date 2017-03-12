class CreateAnalytics < ActiveRecord::Migration[5.0]
  def self.up
    create_table :analytics do |t|
      t.string :period
      t.integer :location_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :analytics
  end
end
