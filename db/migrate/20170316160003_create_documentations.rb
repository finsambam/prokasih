class CreateDocumentations < ActiveRecord::Migration[5.0]
  def self.up
    create_table :documentations do |t|
    	t.string :title
    	t.string :description
    	t.string :image
      t.timestamps
    end
  end

  def self.down
  	drop_table :documentations
  end
end