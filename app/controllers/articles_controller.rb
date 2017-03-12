class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: :index
  before_filter :find_article, only: [:edit, :update, :destroy]
  
  def index
    
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
    if @article.save!
      redirect_to list_articles_path
    else
      render 'new'
    end 
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to list_articles_path
    else
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
    params.require(:article).permit(:title, :content)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
