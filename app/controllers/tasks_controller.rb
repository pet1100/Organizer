class TasksController < HomeController
  acts_as_resource_controller

  def create
    # params[:task][:user_ids] = params[:task][:user_ids].map(&:to_i)
    _task = params[:task]
    @task = Task.new
    @task.title = _task[:title]
    @task.description= _task[:description]
    @task.repeat_after= _task[:repeat_after]
    if @task.save
      if _task[:user_ids]
        @task.update user_ids: _task[:user_ids]
      else
        @task.update user_ids: User.pluck(:id)
      end
      redirect_to root_path, :notice=>translated_title("helpers.flash.created")
    else
      @page_title = translated_title('helpers.titles.new')
      render "shared/new"
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.assigned_tasks.destroy_all
    task.destroy
    redirect_to root_path
  end

  def toggle
    if params[:checked] == "true"
      Task.find(params[:id]).update completed_at: Time.now
    else
      Task.find(params[:id]).update completed_at: nil
    end
  end

private

  def after_update_path
    redirect_to root_path, :notice=>translated_title("helpers.flash.created")
  end

  def permitted_attributes
    params.require(:task).permit(:title, :description, :repeat_after, user_ids: [])
  end
end