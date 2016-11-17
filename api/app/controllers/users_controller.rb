class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
          flash[:success] = "Welcome to SpotCheck!"
          redirect_to root_path
        else
          flash[:danger] = @user.errors.full_messages.to_sentence
          redirect_to new_user_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
