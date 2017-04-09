class AddContentPreviewToArticles < ActiveRecord::Migration[5.0]
  def change
  	add_column :articles, :content_preview, :string 
  end
end
