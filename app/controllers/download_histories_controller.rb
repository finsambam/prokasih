class DownloadHistoriesController < ApplicationController
	before_filter :authenticate_user!
  def index
  	@download_histories = DownloadHistory.order('created_at DESC')
  end

end