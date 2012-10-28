class Admin::AmenitiesController < Admin::AdminController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @amenity.save
      redirect_to admin_amenities_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @amenity.update_attributes(params[:amenity])
      redirect_to admin_amenities_path
    else
      render 'edit'
    end
  end

  def destroy
    @amenity.destroy
 
    redirect_to admin_amenities_path
  end 
end
