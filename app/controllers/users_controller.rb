class UsersController < ApplicationController

  def index

  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)

    if params[:user][:password] != params[:user][:password_confirmation]
      flash.now[:notice] = "Your password confirmation did not match"
      render 'new'
    else
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        flash.now[:notice] = "Your information did not save. Please try again."
        render 'new'
      end
    end
  end

  def show
    user = current_user
    @urls = user.urls
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
