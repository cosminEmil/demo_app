class Comment < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :todo_list, optional: true
  belongs_to :user
end
