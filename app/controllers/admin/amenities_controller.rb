class Admin::AmenitiesController < Admin::AdminController
  load_and_authorize_resource

  def index
    @amenities = Amenity.all
  end

  def new
    @amenity = Amenity.new
  end

  def create
    @amenity = Amenity.new(params[:amenity])

    if @amenity.save
      redirect_to admin_amenities_path
    end
  end

  def edit
    @amenity = Amenity.find(params[:id])
  end

  def update
    @amenity = Amenity.find(params[:id])

    if @amenity.update_attributes(params[:amenity])
      redirect_to admin_amenities_path
    end
  end

  def destroy
    @amenity = Amenity.find(params[:id])
    @amenity.destroy
 
    redirect_to admin_amenities_path
  end 
end
