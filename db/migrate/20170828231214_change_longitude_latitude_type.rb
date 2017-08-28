class ChangeLongitudeLatitudeType < ActiveRecord::Migration[5.0]
  def change
  	change_column :locations, :longitude, :decimal, :precision => 15, :scale => 8
  	change_column :locations, :latitude, :decimal, :precision => 15, :scale => 8
  end
end