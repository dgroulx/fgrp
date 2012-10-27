class Park < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :address, :contact_info, :flickr_pool, :history, :latitude, :longitude, :name, :park_size, :section, :vimeo_embed, :amenity_ids, :slug
=======
  attr_accessible :address, :contact_info, :flickr_pool, :history, :latitude, :longitude, :name, :park_size, :section, :vimeo_embed, :amenity_ids, :slug
>>>>>>> c13d60676a48516add725ef0d07caa9b348c25ab

  has_many :park_amenities
  has_many :amenities, through: :park_amenities

  validates :name, presence: true, uniqueness: true
  validates :address, :longitude, :latitude, presence: true

  before_create :generate_slug
  before_save :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.parameterize
  end
end
