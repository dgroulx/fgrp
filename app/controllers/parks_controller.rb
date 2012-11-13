class ParksController < ApplicationController
  def index
    @amenities = Amenity.all
  	@allParks = Park.all
    if params[:amenity_id].present?
      selected_amenities = params[:amenity_id].map(&:to_i) 
      @parks = Park.all.select{|park| (selected_amenities - park.amenity_ids).empty?}
    else 
      @parks = @allParks
    end
  
    if params[:distance].present?
      distance = params[:distance].to_f
      lat = params[:lat].to_f
      lng = params[:lng].to_f
      @parks = @parks.select{ |x| haversine_distance(lat, lng, x.latitude, x.longitude) < distance }
    end

    @facts = Fact.find(Fact.pluck(:id).sample(4))
  
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @parks.to_json }
    end
  end

  def show
    @park = Park.find_by_slug(params[:id])

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @park.to_json }
    end
  end

  private

  # PI = 3.1415926535
	RAD_PER_DEG = 0.017453293  #  PI/180

	Rmiles = 3956           # radius of the great circle in miles

	def haversine_distance( lat1, lon1, lat2, lon2 )

		dlon = lon2 - lon1
		dlat = lat2 - lat1

		dlon_rad = dlon * RAD_PER_DEG 
		dlat_rad = dlat * RAD_PER_DEG

		lat1_rad = lat1 * RAD_PER_DEG
		lon1_rad = lon1 * RAD_PER_DEG

		lat2_rad = lat2 * RAD_PER_DEG
		lon2_rad = lon2 * RAD_PER_DEG

		a = (Math.sin(dlat_rad/2))**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * (Math.sin(dlon_rad/2))**2
		c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))

		dMi = Rmiles * c          # delta between the two points in miles
	end


end
