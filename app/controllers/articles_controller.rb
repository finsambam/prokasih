class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_article, only: [:edit, :update, :destroy, :show]
  
  def index
    @articles = Article.paginate(:page => params[:page]).order('created_at DESC')    
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

    @article.content_preview = create_article_preview(params[:article][:content])
    @article.user = current_user

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
      if @article.documentation_id?
        documentation = Documentation.find(@article.documentation_id)
        documentation.image = params[:article][:image]
        documentation.save!
      else
        documentation = Documentation.find_or_create_by(title: params[:article][:title]) do |d|
          d.image = params[:article][:image]
        end  
      end
      
      params[:article][:documentation_id] = documentation.id
    end
    params[:article][:content_preview] = create_article_preview(params[:article][:content])
    params[:article][:user_id] = current_user.id
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
    params.require(:article).permit(:title, :content, :documentation_id, :user_id, :content_preview)
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def create_article_preview(content)
    temp_content = ActionController::Base.helpers.strip_tags(content)
    return ActionController::Base.helpers.truncate(temp_content, :length => 200)
  end
end
