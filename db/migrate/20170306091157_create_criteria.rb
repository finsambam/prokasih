class CreateCriteria < ActiveRecord::Migration[5.0]
  def self.up
    create_table :criteria do |t|
      t.string :name
      
      t.timestamps
    end
  end

  def self.down
    drop_table :criteria
  end
end
