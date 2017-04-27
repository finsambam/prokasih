class ApplicationMailer < ActionMailer::Base
  default from: 'finsambam@gmail.com'
  layout 'mailer'

  def discuss_notification(comment, isReply)
    @comment = comment
    @isReply = isReply
    if isReply
      @name = @comment.parent.name
      email = @comment.parent.email
    else
      @name = @comment.name
      email = @comment.email
    end
    mail(to: email, subject: isReply ? 'Balasan Diskusi Prokasih' : 'Diskusi Prokasih') 
  end

  def user_registration_notification(user, password)
    @user = user
    @password = password
    mail(to: @user.email, subject: 'Registrasi User Prokasih') 
  end
end
