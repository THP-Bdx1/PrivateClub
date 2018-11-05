class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                    :password_confirmation)
  end

end
