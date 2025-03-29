class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: %i[show edit update destroy]

  def index
    @todo_lists = current_user.todo_lists
  end

  def show
    @todo_list = current_user.todo_lists.find(params[:id])
    @comment = @todo_list.comments.build 
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

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
