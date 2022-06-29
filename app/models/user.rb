class User < ApplicationRecord
  has_many :assigned_tasks
  has_many :tasks, through: :assigned_tasks

  has_secure_password

  validates_length_of :username, :minimum => 3
  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 6
end