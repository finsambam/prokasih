class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_article, only: [:edit, :update, :destroy, :show]
  
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
    begin
      @article = Article.new(article_params)
    
      if params[:article][:image].present?
        documentation = Documentation.find_or_create_by(title: params[:article][:title]) do |d|
          d.image = params[:article][:image]
          d.is_article = true
        end
        if documentation.errors.any?
          @article.errors.add(:documentation, "Anda tidak dapat meng-upload foto lebih dari 1MB")
          raise @article.errors.messages
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
    rescue Exception => e
      render 'new'
    end
     
  end

  def edit
  end

  def update
    begin
      if params[:article][:image].present?
        if @article.documentation_id?
          documentation = Documentation.find(@article.documentation_id)
          documentation.image = params[:article][:image]
          documentation.is_article = true
          documentation.save!
        else
          documentation = Documentation.find_or_create_by(title: params[:article][:title]) do |d|
            d.image = params[:article][:image]
            d.is_article = true
          end
          raise "error" if documentation.errors.any?
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
    rescue Exception => e
      doc_error_key = documentation.errors.messages.keys.first
      @article.errors.add(doc_error_key, documentation.errors.messages[doc_error_key].join(','))
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
