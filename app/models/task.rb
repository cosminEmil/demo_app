class Task < ApplicationRecord
  belongs_to :todo_list
  validates :title, presence: true
  has_many :comments, dependent: :destroy
end
