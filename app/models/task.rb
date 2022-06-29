class Task < ApplicationRecord
  has_many :assigned_tasks
  has_many :users, through: :assigned_tasks
end