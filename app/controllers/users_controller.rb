class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# handle a successful save
			flash[:success] = "Welcome to the ToDo app!"
			redirect_to @user
		else
			# handle an unsuccessful save
			render 'new'
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
