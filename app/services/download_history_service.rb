class DownloadHistoryService
  def initialize(email, reason_to_download, result_type)
    @download_history = DownloadHistory.new(
        :email => email, 
        :purpose_of_download => reason_to_download, 
        :result_type => result_type) 
  end

  def save_to_DB
    begin
      @download_history.save!  
    rescue
      false
    end
    
  end
end