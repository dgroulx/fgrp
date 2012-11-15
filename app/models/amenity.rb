class Amenity < ActiveRecord::Base
  attr_accessible :name

  default_scope order('name ASC')
 
  validates :name, :presence => true
  
  has_many :park_amenities
  has_many :parks, through: :park_amenities
end
