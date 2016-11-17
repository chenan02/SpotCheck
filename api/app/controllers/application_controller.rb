class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def index
        if session[:user]
            @user = User.find(session[:user]["id"])
        end
        render file: 'index.html.erb'
    end
end
