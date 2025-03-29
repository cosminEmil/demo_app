class SharedList < ApplicationRecord
  belongs_to :user
  belongs_to :todo_list

  validates :permission_level, inclusion: { in: [true, false], message: "must be true (read_write) or false (read_only)" }
  validates :user_id, uniqueness: { scope: :todo_list_id, message: "is already added to this list" }
  def read_write?
    permission_level == true
  end

  def read_only?
    permission_level == false
  end
end
