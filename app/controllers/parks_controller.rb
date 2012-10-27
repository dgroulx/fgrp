class ParksController < ApplicationController
  def index
  if params[:amenity_id].present?
    @parks = Park.joins(:amenities).where("amenities.id = ?", params[:amenity_id])
  else 
    @parks = Park.all
  end

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

  def find
	@parks = Park.joins(:amenities).where("amenities.id = ?", params[:amenity_id])

	respond_to do |format|
      format.json { render json: @parks.to_json }
    end
  end
end
