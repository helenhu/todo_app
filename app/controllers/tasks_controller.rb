class TasksController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :update]
	before_action :correct_user,	 only: [:destroy, :update]

	def create
		@task = current_user.tasks.build(task_params)
		if @task.save
			flash[:success] = "Task created!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def destroy
		@task.destroy
		redirect_to request.referrer || root_url
	end

	def update
		@task.update_attribute(:checked, !@task.checked)
		redirect_to request.referrer || root_url
	end

	private

		def task_params
			params.require(:task).permit(:content)
		end

		def correct_user
			@task = current_user.tasks.find_by(id: params[:id])
			redirect_to root_url if @task.nil?
		end
end
