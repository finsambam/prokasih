class CreateDownloadHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :download_histories do |t|
      t.string :email
      t.string :result_type
      t.string :purpose_of_download

      t.timestamps
    end
  end
end
