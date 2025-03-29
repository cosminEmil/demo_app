class SharedListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list

  def create
    # Ensure that only the owner of the to-do list can share it with others
    unless @todo_list.user == current_user
      redirect_to @todo_list, alert: "You are not authorized to share this list."
      return
    end
  
    # Proceed with sharing the list if the user is authorized
    shared_user = User.find_by(email: params[:shared_list][:email])
  
    if shared_user.nil?
      redirect_to @todo_list, alert: "User not found"
      return
    end
  
    permission_level = ActiveRecord::Type::Boolean.new.cast(params[:shared_list][:permission_level])
  
    # Create the shared list entry
    shared_list = @todo_list.shared_lists.new(user: shared_user, permission_level: permission_level)
    if shared_list.save
      redirect_to @todo_list, notice: "User added successfully!"
    else
      redirect_to @todo_list, alert: shared_list.errors.full_messages.join(", ")
    end
  end
  

  def update
    shared_list = @todo_list.shared_lists.find(params[:id])

    # Ensure the current user is the owner of the to-do list or has read-write permission
    unless @todo_list.user == current_user
      redirect_to @todo_list, alert: "You do not have permission to change this user's permissions."
      return
    end

    # Attempt to update the permission level
    if shared_list.update(permission_level: params[:shared_list][:permission_level])
      redirect_to @todo_list, notice: "User's permissions updated successfully!"
    else
      # If there's an issue updating, display the error messages
      redirect_to @todo_list, alert: shared_list.errors.full_messages.join(", ")
    end
  end


  def destroy
    # Find the shared list entry based on the provided todo_list_id and shared_list id
    shared_list = @todo_list.shared_lists.find(params[:id])
  
    # Ensure that only the owner of the to-do list can delete a shared user
    if @todo_list.user == current_user
      shared_list.destroy
      redirect_to @todo_list, notice: "User removed from shared list"
    else
      redirect_to @todo_list, alert: "You are not authorized to remove this user from the shared list."
    end
  end
  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end
end
