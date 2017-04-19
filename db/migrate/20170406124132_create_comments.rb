class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :email
      t.string :message
      t.integer :parent_id

      t.timestamps
    end
  end
end
