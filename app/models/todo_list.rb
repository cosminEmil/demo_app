class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shared_lists, dependent: :destroy
  has_many :shared_users, through: :shared_lists, source: :user
  
  validates :title, presence: true
end
