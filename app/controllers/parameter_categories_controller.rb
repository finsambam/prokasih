class ParameterCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_parameter_category, only: [:edit, :update, :destroy]
  
  def index
    @parameter_categories = ParameterCategory.order('created_at DESC')
  end

  def new
    @parameter_category = ParameterCategory.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    begin
      @parameter_category = ParameterCategory.new(parameter_category_params)
      if @parameter_category.save!
        redirect_to parameter_categories_path
      else
        render 'new'
      end  
    rescue Exception => e
      render 'new'
    end
     
  end

  def edit
  end

  def update
    begin
      if @parameter_category.update_attributes(parameter_category_params)
        redirect_to parameter_categories_path
      else
        render 'edit'
      end  
    rescue Exception => e
      render 'edit'
    end
    
  end

  def destroy
    @parameter_category.destroy!
    redirect_to parameter_categories_path
  end

  private

  def parameter_category_params
    params.require(:parameter_category).permit(:name)
  end

  def find_parameter_category
    @parameter_category = ParameterCategory.find(params[:id])
  end
end
