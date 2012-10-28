class Park < ActiveRecord::Base
  attr_accessible :id, :address, :contact_info, :flickr_pool, :history, :latitude, :longitude, :name, :park_size, :vimeo_embed, :amenity_ids, :slug, :links_attributes, :park_amenities_attributes

  has_many :park_amenities, dependent: :destroy
  has_many :amenities, through: :park_amenities
  has_many :links, class_name: "ParkLink", dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: lambda { |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :park_amenities, reject_if: lambda { |a| a[:amenity_id].blank? }, allow_destroy: true

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
