class CreateArticles < ActiveRecord::Migration[5.0]
  def self.up
    create_table :articles do |t|
    	t.string :title
    	t.column :content, :mediumtext

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
