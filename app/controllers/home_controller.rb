class HomeController < ApplicationController
  before_action :reopen_tasks

  def index
  end

  def current_user
    User.find(session[:user_id])
  end
  helper_method :current_user

  def tasks
    return [] if current_user.tasks.empty?
    unless @tasks
      tasks = current_user.tasks
      task_ids = tasks.uncompleted.pluck(:id)
      task_ids << tasks.completed.repeatable.pluck(:id)
      @tasks = tasks.find(task_ids)
    end
    @tasks
  end
  helper_method :tasks

  private
  def reopen_tasks
    if current_user.refreshable?
      current_user.tasks.each do |task|
        task.reopen
      end
    end
  end
end
