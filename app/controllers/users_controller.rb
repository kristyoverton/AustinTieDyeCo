class UsersController < ApplicationController
	before_action :require_signin, only: [:index, :show, :edit, :update, :destroy]
  layout "users"



  def index
    puts flash[:notice]
    @firstname = current_user[:first_name]
    @blankets = User.find(current_user[:id]).blankets
    @blanket = Blanket.new
    @location = Location.new
  end

  def create_location
    @location = Location.new
  end

  #   Form to make new user
  def new 
    @user = User.new
  end

  #   Restful route to actually make the new user
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user, false
      redirect_to users_dash_path, notice: 'User was successfully registered'
   else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  #   Form to update a user
  def edit
    @user = User.find(params[:id])

    deny_wrong_user if !current_user?(@user)
  end

  def dash
  end

  #   Restful route to actually change the user info
  def update
    user = User.find(params[:id])

    deny_wrong_user if !current_user?(user)

    if user.update(user_params)
        redirect_to user, notice: 'User was successfully updated.'
    else
        flash[:errors] = user.errors.full_messages
        redirect_to edit_user_path(params[:id]), alert: 'User was not updated'
    end
  end

  #   Restful route to actually delete the user
  def destroy
    u = User.find(params[:id])
    
    if u.id == @current_user.id
        flash[:alert] = "Please don't destroy yourself - it isn't healthy!"
    elsif u.destroy == false
        flash[:errors] = u.errors.full_messages
    end
    redirect_to users_path
  end

  def checkIn
    pos = Location.new(location_params)
      if pos.save
        flash[:lat] = pos.lat
        flash[:long] = pos.long
        redirect_to map_path
      end
  end

  def map
    
    @lat = flash[:lat]
    if @lat.nil? 
      @lat = 30.266962
    end
    @lon = flash[:long]
     if @lon.nil?
      @lon = -97.772859
    end

  # client = Twitter::REST::Client.new do |config|
   #    config.consumer_key    = TWITTER_CONSUMER_KEY
  #    config.consumer_secret = TWITTER_CONSUMER_SECRET
   #     config.access_token    = TWITTER_ACCESS_TOKEN
    #   config.access_token_secret = TWITTER_ACCESS_TOKEN_SECRET
   # end

   # @tweet = client.search(geocode:'#{@lat},#{@lon},5mi', result_type: "recent").take(1)
  # @tweet = random_fact(@lat,@lon)
    @locations = Location.nearby(@lat,@lon)
    @location = Location.new
  end

  #   Define strong parameters
  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :address1, :address2, :city, :state, :zip, :password, :password_confirmation)
    end
    def location_params
      params.require(:location).permit(:lat, :long, :created_at)
    end
end

