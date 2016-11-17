class SessionsController < ApplicationController
    def create
        @user = User.find_by(username: params[:username])
        if @user && params[:password] == @user.password
          session[:user] = @user
          flash[:success] = "Signed in"
          return redirect_to root_path
        end
        flash[:danger] = "Invalid credentials"
        redirect_to new_session_path
    end

    def destroy
        session[:user] = nil
        redirect_to root_path
    end
end
