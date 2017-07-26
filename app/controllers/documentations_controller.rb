class DocumentationsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :get_json]
  before_filter :find_documentation, only: [:edit, :update, :destroy, :show, :get_json]
  
  def index
    @documentations = Documentation.not_article.paginate(:page => params[:page]).order('created_at DESC')    
  end

  def show
    # respond_to do |format|
    #   format.js
    # end
  end

  # page for administrator
  # ==========================================================
  def list
    @documentations = Documentation.not_article.order('created_at DESC')
  end

  def new
    @documentation = Documentation.new
  end

  def create
    begin
      @documentation = Documentation.new(documentation_params)
      @documentation.is_article = false
      if @documentation.save!
        redirect_to list_documentations_path
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
      @documentation.is_article = false
      if @documentation.update_attributes(documentation_params)
        redirect_to list_documentations_path
      else
        render 'edit'
      end  
    rescue Exception => e
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
    params.require(:documentation).permit(:title, :description, :image, :is_article)
  end

  def find_documentation
    @documentation = Documentation.find(params[:id])
  end
end
