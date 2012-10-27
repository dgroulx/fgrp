class AddDataToParkAmenities < ActiveRecord::Migration
  def change
    add_column :park_amenities, :description, :string
    add_column :park_amenities, :latitude, :float
    add_column :park_amenities, :longitude, :float 
  end
end
