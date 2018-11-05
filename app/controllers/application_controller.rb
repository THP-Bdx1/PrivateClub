class ApplicationController < ActionController::Base
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
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


    def record_not_found
      render plain: "La page demandée n'existe pas", status: 404
    end

end