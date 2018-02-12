
class UserMailer < ApplicationMailer
  default from: 'prajaktabande1711@gmail.com'

  def welcome_email(params)
    mail(to: params['your-email'], subject: params['your-subject'])do |format|
      format.html {
        render locals: { first_name: params['first-name'],last_name: params['last-name'],mobile_num: params['your-phone'],your_message: params['your-message'] }
      }
    end

  end

end
