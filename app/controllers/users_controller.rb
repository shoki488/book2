class UsersController < ApplicationController
  def index
    @user = current_user if user_signed_in?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    @user.image = "default-avatar.png"
    if @user.save
      log_in @user
      redirect_to @user 
    else
      render 'new'
    end
  end

  def show

  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update 
  end


  def destroy
  end
  
  def account
  end
   
  def profile
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
