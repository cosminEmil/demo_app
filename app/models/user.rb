class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :todo_lists
  has_many :shared_lists, dependent: :destroy
  has_many :shared_todo_lists, through: :shared_lists, source: :todo_list
end
