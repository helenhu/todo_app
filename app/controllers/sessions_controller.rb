class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		# Log the current user in and redirect to user's show page.
  		log_in user
  		flash[:success] = "Welcome to the ToDo app!"
  		redirect_to user
  	else
  		# Create an error message
  		flash.now[:danger] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end
end
