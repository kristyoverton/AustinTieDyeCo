class AdminsController < ApplicationController
	before_action :require_signin, except: :index
  	before_action :require_admin, except: :index
  	before_action :require_super_admin, only: [:new, :create, :showall, :edit, :update, :destroy]
  	before_action :set_level
	
	def index
		if signed_in?
			redirect_to admins_dash_path
		else
			@admin = Admin.new
		end
	end

	def showall
		@admins = Admin.all
	end

	def showusers
		@users = User.all.select(:first_name, :last_name, :email, :id).order(last_name: :asc)
	end

	def showOneUser
		@user = User.find(params[:id])
	end

	def editUser
		@user = User.find(params[:id])
	end

	def updateUser
		user = User.find(params[:id]).update_columns(user_params)
		if user
			redirect_to admins_dash_path, notice: "Customer updated successfully!"
		else
			render :text => user.error.full_messages
		   # redirect_to admins_dash_path, alert: "Something went wrong. Try again?"
		end
	end

	def new
		@admin = Admin.new
	end

	def create
		@admin = Admin.new(admin_params)
		@admin.level = 2
		if @admin.save
		      redirect_to admins_dash_path, notice: 'User was successfully registered'
		else
		      flash[:errors] = @admin.errors.full_messages
		      redirect_to admins_path, alert: @admin.errors.full_messages
    	end
	end

	def dash
		@email = current_user[:email]
	end

	def edit
		@admin = Admin.find(params[:id])
	end

	def update
		if Admin.find(params[:id]).update(admin_params)
			redirect_to admins_dash_path, notice: "Admin updated successfully!"
		else
		    redirect_to admins_dash_path, alert: "Something went wrong, try again."
		end
	end

	def destroy
		Admin.delete(params[:id])
		redirect_to admins_dash_path, notice: "Admin deleted successfully."
	end

	private
    def admin_params
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :address1, :address2, :city, :state, :zip)
    end
end
