class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list
  before_action :set_task, only: %i[show edit update destroy toggle_status]

  def index
    @tasks = @todo_list.tasks
  end

  def show
  end

  def new
    @task = @todo_list.tasks.new
  end

  def create
    @task = @todo_list.tasks.new(task_params)
    if @task.save
      redirect_to todo_list_path(@todo_list), notice: 'Task added successfully!'
    else
       flash.now[:alert] = 'Please fill in the title.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to todo_list_path(@todo_list), notice: 'Task updated successfully!'
    else
       flash.now[:alert] = 'Please fill in the title.'
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

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def set_task
    @task = @todo_list.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed)
  end
end
