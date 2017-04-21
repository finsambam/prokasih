class HomeController < ApplicationController
	
	def index
		@articles = Article.order("created_at DESC").limit(5)
		@article_titles = @articles.map { |a| a.title }
	end
end
