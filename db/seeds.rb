require 'csv'

User.destroy_all
User.create(email: "admin@fgrp.org", password: "password", password_confirmation: "password", admin: true)
User.create(email: "user@fgrp.org", password: "password", password_confirmation: "password")

Park.destroy_all
Amenity.destroy_all
ParkAmenity.destroy_all

parks = CSV.read(Rails.root.join("db", "parks.csv"))
amenities = CSV.read(Rails.root.join("db", "amenities.csv"))
park_amenities = CSV.read(Rails.root.join("db", "park_amenities.csv"))

amenity_colnames = amenities.shift.map!(&:strip)
amenity_hash = {}
amenities.each do |amenity|
  amenity_row = amenity_colnames.zip(amenity).inject({}) do |result, col|
    result[col[0]] = col[1].present? ? col[1].strip : nil
    result
  end
  amenity_hash[amenity_row["id"]] = amenity_row

  Amenity.create!(name: amenity_row["name"])
end

park_colnames = parks.shift.map!(&:strip)
park_hash = {}
parks.each do |park|
  park_row = park_colnames.zip(park).inject({}) do |result, col|
    result[col[0]] = col[1].present? ? col[1].strip : nil
    result
  end
  park_hash[park_row["id"]] = park_row

  Park.create!(name: park_row["name"], 
               history: park_row["history"],
               latitude: park_row["latitude"],
               longitude: park_row["longitude"],
               park_size: park_row["park_size"],
               address: park_row["address"],
               vimeo_embed: park_row["vimeo_embed"],
               flickr_pool: park_row["flickr_pool_id"])
end

park_amenity_colnames = park_amenities.shift.map!(&:strip)
park_amenities.each do |park_amenity|
  park_amenity_row = park_amenity_colnames.zip(park_amenity).inject({}) do |result, col|
    result[col[0]] = col[1].present? ? col[1].strip : nil
    result
  end

  park = park_hash[park_amenity_row["park_id"]]
  amenity = amenity_hash[park_amenity_row["amenity_id"]]
  description = park_amenity_row["description"]
#  park_id = park_hash[park_amenity_row["park_id"]]["id"] if park_hash
#  amenity_id = amenity_hash[park_amenity_row["amenity_id"]]["id"] 
  
  if park and amenity 
    ParkAmenity.create!(description: description,
                        park_id: park["id"],
                        amenity_id: amenity["id"])
  end
end

