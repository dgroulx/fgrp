class Admin::ParksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @park = Park.new
  end

  def create
    @park = Park.new(params[:park])

    if @park.save
      redirect_to admin_park_path(@park)
    end
  end

  def edit
  end

  def update
    @park = Park.find(params[:id])

    if @park.update_attributes(params[:park])
      redirect_to admin_park_path(@park)
    end
  end

  def destroy
    @park = Park.find(params[:id])
    @park.destroy

    redirect_to admin_parks_path
  end
end
