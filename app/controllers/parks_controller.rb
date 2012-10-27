class ParksController < ApplicationController
  def index
    @amenities = Amenity.all
    if params[:amenity_id].present?
      @parks = Park.joins(:amenities).where("amenities.id = ?", params[:amenity_id])
    else 
      @parks = Park.all
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
  
  def ufp
    uri = URI.parse("http://treemap.urbanforestproject.com/search/?lat=" + params[:lat] + "&lon=" + params[:lng])
    response = Net::HTTP.get_response(uri)
    respond_to do |format|
      format.json { render json: response.body }
    end
  end
end
