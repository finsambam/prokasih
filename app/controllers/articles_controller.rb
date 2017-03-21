class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: :index
  before_filter :find_article, only: [:edit, :update, :destroy, :show]
  
  def index
    
  end

  def show
    
  end

  # page for administrator
  # ==========================================================
  def list
    @articles = Article.order('created_at DESC')
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    
    if params[:article][:image].present?
      documentation = Documentation.find_or_create_by(title: params[:article][:title]) do |d|
        d.image = params[:article][:image]
      end
      @article.documentation = documentation
    end

    if @article.save!
      redirect_to list_articles_path
    else
      if documentation.present?
        documentation.destroy!
      end
      render 'new'
    end 
  end

  def edit
  end

  def update
    if params[:article][:image].present?
      documentation = Documentation.find_or_create_by(title: params[:article][:title]) do |d|
        d.image = params[:article][:image]
      end
      params[:article][:documentation_id] = documentation.id
    end

    if @article.update_attributes(article_params)
      redirect_to list_articles_path
    else
      if documentation.present?
        documentation.destroy!
      end
      render 'edit'
    end
  end

  def destroy
    @article.destroy!
    redirect_to list_articles_path
  end
  # ==========================================================

  private

  def article_params
    params.require(:article).permit(:title, :content, :documentation_id)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
