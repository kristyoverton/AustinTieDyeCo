class BlanketsController < ApplicationController
	layout "admins", except: :userShow
	
	before_action :require_signin
	before_action :require_admin, except: [:userCreate, :userShow, :userUpdate, :unregister]
	before_action :set_level, except: [:userCreate, :userShow, :userUpdate, :unregister]

	def index
		@blankets = Blanket.all.reverse_order
	end

	def new
		@blanket = Blanket.new
	end

	def show
		@blanket = Blanket.includes(:user).find(params[:id])
	end

	def userShow
		@blanket = Blanket.includes(:user).find(params[:id])
		render :layout => 'users'
	end

	def create
		@blanket = Blanket.new(blanket_params)
		if @blanket.save
			redirect_to blankets_path, notice: "Blanket successfully added!"
		else
			flash[:errors] = @blanket.errors.full_messages
		    redirect_to new_blanket_path
		end
	end

	def userCreate

		if !Blanket.exists?(blanket_params[:id])
		    redirect_to users_dash_path, alert: "Oops, couldn't find a blanket with that ID. Did you mistype the number?"
		elsif !Blanket.find(blanket_params[:id]).user.nil?
		    redirect_to users_dash_path, alert: "Oops, that blanket is already registered. Did you mistype the number?"
		elsif Blanket.find(blanket_params[:id]).update(user_id: current_user[:id], name:blanket_params[:name])
				redirect_to users_dash_path, notice: "Blanket successfully added!"
		else
			flash[:errors] = @blanket.errors.full_messages
		    redirect_to users_dash_path
		end
	end

	def edit
		@blanket = Blanket.find(params[:id])
	end 

	def edituser
		@blanket = Blanket.includes(:user).find(params[:id])
	end

	def update
		if Blanket.find(params[:id]).update(blanket_params)
			redirect_to blankets_path, notice: "Blanket updated successfully!"
		else
			flash[:errors] = @blanket.errors.full_messages
		    redirect_to edit_blanket_path
		end
	end

	def userUpdate
		if Blanket.find(params[:id]).update(blanket_params)
			redirect_to users_dash_path, notice: "Blanket updated successfully!"
		else
			flash[:errors] = @blanket.errors.full_messages
		    redirect_to user_edit_blanket_path
		end
	end

	def unregister
		if Blanket.find(params[:id]).update(user_id: nil,name:nil)
			redirect_to users_dash_path, notice: "Blanket updated successfully!"
		else
			flash[:errors] = @blanket.errors.full_messages
		    redirect_to user_edit_blanket_path
		end
	end

	def destroy
		Blanket.delete(params[:id])
		redirect_to blankets_path, notice: "Blanket deleted successfully."
	end

	private
	def blanket_params
		params.require(:blanket).permit(:id,:desc,:creators,:story,:price,:name, :user_id,:img,:created_at,
			:user)
	end
end
