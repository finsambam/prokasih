class LocationsController < ApplicationController
  before_filter :authenticate_user!
	before_filter :find_location, only: [:edit, :update, :destroy]

  def index
    @locations = Location.order('created_at DESC')
  end

  def new
    @location = Location.new
    @rivers = Location::RIVERS
  end

  def create
    begin
      @location = Location.new(location_params)
      @location[:code] = get_location_code(@location)
      if @location.save
        flash[:success] = "Tambah lokasi berhasil"
        redirect_to locations_path
      else
        @rivers = Location::RIVERS
        render 'new'
      end  
    rescue Exception => e
      @rivers = Location::RIVERS
      render 'new'
    end
  end

  def edit
    @rivers = Location::RIVERS
  end

  def update
    begin
      if @location.update_attributes(location_params)
        redirect_to locations_path
      else
        render 'edit'
      end  
    rescue Exception => e
      render 'edit'     
    end
  end

  def destroy
    @location.destroy!
    redirect_to locations_path
  end

  def get_by_river
    locations = Location.by_river_name(params["riverName"])
    respond_to do |format|
      format.json  { render :json => locations }
    end
  end

  private

  def get_location_code(location)
  	last_item_by_river = Location.where river_name: location[:river_name]
    "#{location.get_code_prefix}-#{last_item_by_river.length+1}"
  end

  def location_params
    params.require(:location).permit(:river_name, :spot_name, :address, :longitude, :latitude)
  end

  def find_location
    @location = Location.find(params[:id])
  end
end
