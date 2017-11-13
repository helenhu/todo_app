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
    # Update task
    first_task = @user.tasks.first
    assert_not first_task.checked
    patch task_path(first_task)
    first_task.reload
    assert first_task.checked
  	# Delete task
  	assert_select 'a', class: "task_delete"
  	assert_difference 'Task.count', -1 do 
  		delete task_path(first_task)
  	end
  end
end
