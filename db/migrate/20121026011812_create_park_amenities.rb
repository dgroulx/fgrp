class CreateParkAmenities < ActiveRecord::Migration
  def change
    create_table :park_amenities do |t|
      t.integer :park_id
      t.integer :amenity_id

      t.timestamps
    end
  end
end
