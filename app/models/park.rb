class Park < ActiveRecord::Base
  attr_accessible :address, :contact_info, :flicker_pool, :history, :latitude, :longitude, :name, :park_size, :section, :vimeo_embed, :amenity_ids

  has_many :park_amenities
  has_many :amenities, through: :park_amenities

  validates :name, presence: true, uniqueness: true
end
