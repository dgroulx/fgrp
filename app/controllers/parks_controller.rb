class ParksController < ApplicationController
  def index
    @parks = Park.all
  end

  def show
    @park = Park.find_by_slug(params[:id])
  end
end
