class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :require_login

  private

  def require_login
    unless logged_in?
      flash[:danger] = "Tu dois être enregistré pour accéder à cette page, petit malin ;)"
      redirect_to login_path # halts request cycle
    end
  end
end
