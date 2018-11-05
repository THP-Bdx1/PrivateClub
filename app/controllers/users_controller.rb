class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :show]
  
  before_action :validate_user, only: [:edit, :update]

  def validate_user
    unless current_user.id.to_s == params[:id]
    flash[:danger] = "Tu ne peux accéder qu'à ton profil, petit malin ;)"
    redirect_to login_path # halts request cycle
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)   # Not the final implementation!
      if @user.save
        log_in @user
        flash[:success] = "Bienvenue au Private Club"
      redirect_to @user
      else
        render 'new'
      end
  end

  def show
      @user = User.find(params[:id])
end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    @user.update(user_params)
    redirect_to "/users/#{current_user.id}/"
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                    :password_confirmation)
  end

end
