class Admin::FactsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @fact.save
      redirect_to admin_facts_path
    end
  end

  def edit
  end

  def update
    if @fact.update_attributes(params[:fact])
      redirect_to admin_facts_path
    end
  end

  def destroy
    @fact.destroy

    redirect_to admin_facts_path
  end
end
