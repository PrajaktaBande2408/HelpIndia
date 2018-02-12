class WelcomeController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def welcome
  end
  def works

  end
  def index

  end
  def create
        UserMailer.welcome_email(params).deliver_now
  end
end
