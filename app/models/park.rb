class Park < ActiveRecord::Base
  attr_accessible :address, :contact_info, :flicker_pool, :history, :latitude, :longitude, :name, :park_size, :section, :vimeo_embed
end
