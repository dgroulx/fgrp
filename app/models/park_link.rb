class ParkLink < ActiveRecord::Base
  attr_accessible :name, :url, :park_id

  belongs_to :park
end
