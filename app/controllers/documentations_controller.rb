class DocumentationsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_documentation, only: [:edit, :update, :destroy, :show]
  
  def index
    @documentations = Documentation.paginate(:page => params[:page]).order('created_at DESC')    
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  # page for administrator
  # ==========================================================
  def list
    @documentations = Documentation.order('created_at DESC')
  end

  def new
    @documentation = Documentation.new
  end

  def create
    @documentation = Documentation.new(documentation_params)
    if @documentation.save!
      redirect_to list_documentations_path
    else
      render 'new'
    end 
  end

  def edit
  end

  def update
    if @documentation.update_attributes(documentation_params)
      redirect_to list_documentations_path
    else
      render 'edit'
    end
  end

  def destroy
    @documentation.destroy!
    redirect_to list_documentations_path
  end
  # ==========================================================

  private

  def documentation_params
    params.require(:documentation).permit(:title, :description, :image)
  end

  def find_documentation
    @documentation = Documentation.find(params[:id])
  end
end
