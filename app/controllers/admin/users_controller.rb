class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_users_path }
        format.json { render nothing: true }
      else
        format.html { render 'new' }
        format.json { render nothing: true }
      end
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_path
  end
end
