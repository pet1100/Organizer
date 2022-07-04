class TasksController < HomeController
  acts_as_resource_controller

  def permitted_attributes
    params.require(:task).permit(:title, :description, :repeat_after, {users: []},)
  end
end