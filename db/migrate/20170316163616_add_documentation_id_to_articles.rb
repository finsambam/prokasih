class AddDocumentationIdToArticles < ActiveRecord::Migration[5.0]
  def change
  	add_column :articles, :documentation_id, :integer
  end
end
