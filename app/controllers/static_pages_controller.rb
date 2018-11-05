class StaticPagesController < ApplicationController
    skip_before_action :require_login, only: [:home]
    
    def home
    end

    def private_home
    @users=User.all
    end
end
