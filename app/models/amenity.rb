class Amenity < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true
  
  has_many :park_amenities
  has_many :parks, through: :park_amenities
end
