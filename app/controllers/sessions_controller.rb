class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: 'Welcome, you are logged in.'
    else
        flash[:error] = "Username or password is incorrect, or not registered."
        redirect_to login_path
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end