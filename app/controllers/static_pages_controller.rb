class StaticPagesController < ApplicationController
  def home
  	@task = Task.new if logged_in?
  end

  def about
  end

  def contact
  end
end
