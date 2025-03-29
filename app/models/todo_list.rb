class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title, presence: true
  has_many :comments, dependent: :destroy
end
