class ParkLink < ActiveRecord::Base
  attr_accessible :park_id, :name, :url

  belongs_to :park
end
