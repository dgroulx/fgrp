class ParkAmenity < ActiveRecord::Base
  attr_accessible :amenity_id, :description, :park_id

  belongs_to :amenity
  belongs_to :park

  delegate :name, to: :park
end
