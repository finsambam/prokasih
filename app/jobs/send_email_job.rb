class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(object)
    if object[:type] == "discuss"
    	discuss_email(object[:comment])
    end
  end

  private

  def discuss_email(comment)
		ApplicationMailer.discuss_notification(comment, comment.parent_id.present? ? true : false).deliver_later
  end
end
