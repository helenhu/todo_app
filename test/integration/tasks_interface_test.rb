require 'test_helper'

class TasksInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:bojack)
  end

  test "micropost interface" do
  	log_in_as(@user)
  	get root_path
  	# Invalid submission
  	assert_no_difference 'Task.count' do
  		post tasks_path, params: { task: { content: "" } }
  	end
  	assert_select "div#error_explanation"
  	# Valid submission
  	content = "Finish productivity app"
  	assert_difference 'Task.count', 1 do
  		post tasks_path, params: { task: { content: content } }
  	end
  	assert_redirected_to root_url
  	follow_redirect!
  	assert_match content, response.body
  	# Delete post
  	assert_select 'a', text: 'X'
  	first_task = @user.tasks.first
  	assert_difference 'Task.count', -1 do 
  		delete task_path(first_task)
  	end
  end
end
