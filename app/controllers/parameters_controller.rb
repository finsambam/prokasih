class ParametersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_parameter_categories, only: [:new, :create, :edit, :update]
  before_filter :find_parameter, only: [:edit, :update, :destroy]
  
  def index
    @parameters = Parameter.order('created_at DESC')
  end

  def new
    @parameter = Parameter.new
  end

  def create
    @parameter = Parameter.new(parameter_params)
    
    if params[:parameter_category_name].present?
      category = ParameterCategory.find_or_create_by(name: params[:parameter_category_name])
      @parameter.parameter_category = category
    end

    if @parameter.save!
      redirect_to parameters_path
    else
      if category.present?
        category.destroy!
      end
      render 'new'
    end 
  end

  def edit
  end

  def update
    if params[:parameter_category_name].present?
      category = ParameterCategory.find_or_create_by(name: params[:parameter_category_name])
      params[:parameter][:parameter_category_id] = category.id
    end

    if @parameter.update_attributes(parameter_params)
      redirect_to parameters_path
    else
      if category.present?
        category.destroy!
      end
      render 'edit'
    end
  end

  def destroy
    @parameter.destroy!
    redirect_to parameters_path
  end

  private

  def parameter_params
    params.require(:parameter).permit(:name, :unit, :parameter_category_id)
  end

  def get_parameter_categories
    @parameter_categories = ParameterCategory.order('created_at DESC')
  end

  def find_parameter
    @parameter = Parameter.find(params[:id])
  end

end
