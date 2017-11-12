require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  
  def setup
  	@user = users(:bojack)
  	@task = @user.tasks.build(content: "Lorem ipsum")
  end

  test "should be valid" do
  	assert @task.valid?
  end

  test "user id should be present" do
  	@task.user_id = nil
  	assert_not @task.valid?
  end

  test "content should be present" do
  	@task.content = " "
  	assert_not @task.valid?
  end

  test "content should be at most 100 characters" do
  	@task.content = "a" * 101
  	assert_not @task.valid?
  end
end
