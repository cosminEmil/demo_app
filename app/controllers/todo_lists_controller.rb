class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: %i[show edit update destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @todo_lists = TodoList
                   .where('todo_lists.user_id = ? OR EXISTS (SELECT 1 FROM shared_lists WHERE shared_lists.todo_list_id = todo_lists.id AND shared_lists.user_id = ?)', current_user.id, current_user.id)
  end

  def show
    # If no to-do list is found, the user will be redirected
    unless @todo_list
      redirect_to todo_lists_path, alert: "You do not have permission to view this to-do list or the list does not exist."
    end
  end

  def new
    @todo_list = current_user.todo_lists.new
  end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)
    if @todo_list.save
      redirect_to @todo_list, notice: 'Todo List created successfully!'
    else
      flash.now[:alert] = 'Please fill in the title.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list, notice: 'Todo List updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_path, notice: 'Todo List deleted successfully!'
  end

  private

  def authorize_user
    unless @todo_list.user == current_user || @todo_list.shared_lists.exists?(user: current_user, permission_level: :read_write)
      redirect_to todo_lists_path, alert: "You do not have permission to edit this list"
    end
  end

  def set_todo_list
    # First try to find the todo list by the id and the user id
    @todo_list = current_user.todo_lists.find_by(id: params[:id])
    
    # If the list isn't found for the current user, check if the list is shared with them
    @todo_list ||= current_user.shared_lists.find_by(todo_list_id: params[:id])&.todo_list
  
    # If no todo list is found, raise RecordNotFound
    unless @todo_list
      redirect_to todo_lists_path, alert: "You do not have permission to view this to-do list or the list does not exist."
    end
  end
  

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
