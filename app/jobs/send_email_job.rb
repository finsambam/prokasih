class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(object)
    if object[:type] == "discuss"
      discuss_email(object[:comment])
    elsif object[:type] == "user_registration"
      user_registration_email(object[:user], object[:password])
    end
  end

  private

  def discuss_email(comment)
    ApplicationMailer.discuss_notification(comment, comment.parent_id.present? ? true : false).deliver_later
  end

  def user_registration_email(user, password)
    ApplicationMailer.user_registration_notification(user, password).deliver_later
  end
end
