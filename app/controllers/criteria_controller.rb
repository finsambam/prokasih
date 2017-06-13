class CriteriaController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_criterium, only: [:edit, :update, :destroy]
  before_filter :init_parameters, only: [:new, :create, :edit, :update]
  
  def index
    @criteria = Criterium.order('created_at DESC')
  end

  def new
    @criterium = Criterium.new
  end

  def create
    begin
      @criterium = Criterium.new(criterium_params)
      if @criterium.save!
        redirect_to criteria_path
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
      if @criterium.update_attributes(criterium_params)
        redirect_to criteria_path
      else
        render 'edit'
      end  
    rescue Exception => e
      render 'edit'
    end
  end

  def destroy
    @criterium.destroy!
    redirect_to criteria_path
  end

  private

  def criterium_params
    params.require(:criterium).permit(:name,
      :criterium_parameters_attributes => [:id, :parameter_id, :value, :special_character, :value2]
    )
  end

  def find_criterium
    @criterium = Criterium.find(params[:id])
  end

  def init_parameters
    @parameter_categories = ParameterCategory.all
    @parameter_special_characters = Parameter::SPECIAL_CHARACTERS
  end
end