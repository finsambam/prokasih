class AnalyticsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_analytic, only: [:edit, :update, :destroy]
  before_filter :init_data_option, only: [:new, :create, :edit, :update]
  
  def index
    @analytics = Analytic.order('created_at DESC')
  end

  def filter
    if params['start_from_date'].present? && params['end_to_date'].present?
      @analytics = Analytic.in_period(DateTime.parse(params['start_from_date']), DateTime.parse(params['end_to_date']))
      else
      @analytics = Analytic.order('created_at DESC')
    end
    respond_to do |format|
      format.js
    end
  end

  def new
    @analytic = Analytic.new
  end

  def create
    begin
      @analytic = Analytic.new(analytic_params)
      if @analytic.save!
        redirect_to analytics_path
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
      if @analytic.update_attributes(analytic_params)
        redirect_to analytics_path
      else
        render 'edit'
      end  
    rescue Exception => e
      render 'edit'
    end
    
  end

  def destroy
    @analytic.destroy!
    redirect_to analytics_path
  end

  private

  def analytic_params
    params.require(:analytic).permit(:period, :location_id, :criterium_id,
      :analytic_parameters_attributes => [:id, :parameter_id, :value]
    )
  end

  def find_analytic
    @analytic = Analytic.find(params[:id])
  end

  def init_data_option
    @parameter_categories = ParameterCategory.all
    @rivers = Location::RIVERS
    @locations = Location.all
    @criteria = Criterium.all
  end
end
