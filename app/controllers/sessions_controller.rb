class SessionsController < ApplicationController
    layout 'users'
    # bring up a form for a new session, i.e. the login form
    def new
        @location = Location.new    
        if signed_in?
            redirect_to users_dash_path
        else
            @user = User.new
        end
    end

    # create the session resource -- let the user log in
    def createUser
        # this references the function we made in user.rb
        user = User.authenticate(params[:user][:email], params[:user][:password])
        if user.nil?
            # if there is an error, redirect back to login
            redirect_to signin_path, alert: "Couldn't find a user with those credentials"
        else
            sign_in user, false          # helper function
            redirect_to users_dash_path, notice: "You are now signed in"
        end
    end

    def createAdmin
    	admin = Admin.authenticate(params[:admin][:email], params[:admin][:password])
        if admin.nil?
            # if there is an error, redirect back to login
            redirect_to '/admin', alert: "Couldn't find a user with those credentials"
        else
            sign_in admin, true        # helper function
            redirect_to admins_dash_path, notice: "You are now signed in"
        end
    end

    def destroy
        sign_out                # helper function 
        redirect_to signin_path, notice: "You are now signed out"
    end

end