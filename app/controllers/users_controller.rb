class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@tasks = @user.tasks
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# handle a successful save
			@user.send_activation_email
			flash[:info] = "Please check your email to activate your account."
			redirect_to root_url
		else
			# handle an unsuccessful save
			render 'new'
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# Before filters

		# Confirms  the correct user.
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless @user == current_user
		end

end
