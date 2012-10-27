class ParksController < ApplicationController
  def index
    @parks = Park.all

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
end
