class Park < ActiveRecord::Base
  attr_accessible :address, :contact_info, :flickr_pool, :history, :latitude, :longitude, :name, :park_size, :section, :vimeo_embed, :amenity_ids, :slug

  has_many :park_amenities
  has_many :amenities, through: :park_amenities
  has_many :links, class_name: "ParkLink"

  accepts_nested_attributes_for :links

  validates :name, presence: true, uniqueness: true

  before_create :generate_slug
  before_save :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.parameterize
  end
end
