class AddTypeOnDocumentations < ActiveRecord::Migration[5.0]
  def change
  	add_column :documentations, :is_article, :bool 
  end
end
