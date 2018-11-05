class StaticPagesController < ApplicationController
    skip_before_action :require_login, only: [:home]
    
    def home
    end

    def private_home
    @user= User.find(current_user.id)
    @users=User.all
    end
end
