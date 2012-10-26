class Admin::ParksController < Admin::AdminController
  def index
    @parks = Park.all
  end

  def new
    @park = Park.new
  end

  def create
    @park = Park.new(params[:park])

    if @park.save
      redirect_to admin_parks_path
    end
  end

  def edit
    @park = Park.find_by_slug(params[:id])
  end

  def update
    @park = Park.find_by_slug(params[:id])

    if @park.update_attributes(params[:park])
      redirect_to admin_parks_path
    end
  end

  def destroy
    @park = Park.find_by_slug(params[:id])
    @park.destroy

    redirect_to admin_parks_path
  end
end
