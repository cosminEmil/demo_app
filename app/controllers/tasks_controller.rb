class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list
  before_action :set_task, only: %i[show edit update destroy toggle_status]
  before_action :authorize_task_access, only: [:edit, :update, :destroy]

  def index
    @tasks = @todo_list.tasks
  end

  def show
  end

  def new
    # Ensure the user has permission to add tasks (either as the owner or with read-write permission)
    unless @todo_list && (@todo_list.user == current_user || @todo_list.shared_lists.exists?(user_id: current_user.id, permission_level: true))
      redirect_to todo_lists_path, alert: "You do not have permission to add tasks to this list."
    end
  
    @task = @todo_list.tasks.new
  end

  def create
    # Ensure the user has permission to create tasks (either as the owner or with read-write permission)
    unless @todo_list && (@todo_list.user == current_user || @todo_list.shared_lists.exists?(user_id: current_user.id, permission_level: true))
      redirect_to todo_lists_path, alert: "You do not have permission to create tasks for this list."
      return
    end
  
    @task = @todo_list.tasks.new(task_params)
  
    if @task.save
      redirect_to todo_list_path(@todo_list), notice: "Task created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @task = @todo_list.tasks.find(params[:id])
  
    # Check if the user has permission to update the task (read-write or owner)
    unless @todo_list.shared_lists.exists?(user_id: current_user.id, permission_level: true) || @todo_list.user == current_user
      redirect_to todo_list_path(@todo_list), alert: "You do not have permission to update tasks in this list."
      return
    end
  
    # Update task status (completed or not)
    if @task.update(task_params)
      redirect_to todo_list_path(@todo_list), notice: "Task updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  def destroy
    @task.destroy
    redirect_to todo_list_path(@todo_list), notice: 'Task deleted successfully!'
  end

  def toggle_status
    @task.update(completed: !@task.completed)
    redirect_to todo_list_path(@todo_list), notice: 'Task status updated!'
  end

  private

  def authorize_task_access
    unless @todo_list.user == current_user || @todo_list.shared_lists.exists?(user: current_user, permission_level: :read_write)
      redirect_to todo_list_path(@todo_list), alert: "You do not have permission to modify tasks"
    end
  end

  def set_todo_list
    # Try to find the todo list by the user (if it's owned by them)
    @todo_list = current_user.todo_lists.find_by(id: params[:todo_list_id])
  
    # If it's not found, check if the list is shared with the current user
    @todo_list ||= current_user.shared_lists.find_by(todo_list_id: params[:todo_list_id])&.todo_list
  
    # If no todo list is found, raise an error
    raise ActiveRecord::RecordNotFound unless @todo_list
  end

  def set_task
    @task = @todo_list.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed)
  end
end
