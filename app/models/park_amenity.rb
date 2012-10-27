class ParkAmenity < ActiveRecord::Base
  attr_accessible :amenity_id, :description, :park_id, :description, :latitude, :longitude

  belongs_to :amenity
  belongs_to :park
end
