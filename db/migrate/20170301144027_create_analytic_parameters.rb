class CreateAnalyticParameters < ActiveRecord::Migration[5.0]
  def self.up
    create_table :analytic_parameters do |t|
      t.references :analytic, :parameter
      t.string :value
      
      t.timestamps
    end
  end

  def self.down
    drop_table :analytic_parameters
  end
end
