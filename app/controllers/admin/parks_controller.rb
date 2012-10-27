class Admin::ParksController < Admin::AdminController
  load_resource find_by: :slug
  authorize_resource

  def index
  end

  def new
  end

  def create
    if @park.save
      redirect_to admin_parks_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @park.update_attributes(params[:park])
      redirect_to admin_parks_path
    end
  end

  def destroy
    @park.destroy

    redirect_to admin_parks_path
  end
end
