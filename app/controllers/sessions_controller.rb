class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email]).try(:authenticate, params[:session][:password])
    if @user
      login(@user)
      redirect_to user_path(current_user)
    else
      flash.now[:notice] = "You logged in bad"
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    current_user = nil

    redirect_to root_path
  end

end
