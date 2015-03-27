module SessionsHelper
  def set_level
      if signed_in?
        @level = current_user[:level]
      end
    end
  
  #  Before running a certain controller#method, 
  #  require the user to be signed in.
  def require_signin
    deny_access if !signed_in?
  end
  
  #  Before running a certain controller#method, 
  #  require the user to be the admin.
  def require_admin
    deny_wrong_user if !admin?
  end

  def require_super_admin
    deny_wrong_user if @current_user[:level] != 1
  end
  
  #   Once the user is authenticated, 
  #   set the ID in Session and @current_user 
  def sign_in(user, adminlevel)
    session[:user_id] = user.id
    if adminlevel == true
      session[:admin] = true
      self.current_user=(user)
    else
    # set the value of the current user, IE use the method below
      session[:admin] = false
      self.current_user=(user)
    end
  end
  
  # setter method, set the value of the current user as an instance variable!
  def current_user=(user)
    @current_user = user
  end

  # getter method, returns info of current user
  def current_user
    if session[:admin]
      @current_user ||= Admin.find(session[:user_id]) if session[:user_id]
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  #   Is anyone signed in right now?
  def signed_in?
    !current_user.nil?
  end

  #   Is the signed-in user the admin?
  def admin?
    session[:admin] ==true
  end

  #   Is this user the signed-in user?
  def current_user?(user)
    (user == self.current_user) || admin?
  end

  #   Remove from Session, and zero out @current_user
  def sign_out
    session[:user_id] = nil
    session[:admin] = nil
      self.current_user = nil
    redirect_to '/'
  end

  #   Called if require_signin fails.
  #   Go back to signin view, with appropriate notice text.
  def deny_access
    redirect_to signin_path, notice: "Please sign in to access that page."
  end

  #   Called if require_admin fails.
  #   Go back to the signed-in user's view, with appropriate notice text.
  def deny_wrong_user
    redirect_to signin_path, notice: "Sorry, you can't access that page."
  end

end
