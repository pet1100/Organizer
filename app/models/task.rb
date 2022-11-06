class Task < ApplicationRecord
  has_many :assigned_tasks
  has_many :users, through: :assigned_tasks

  scope :uncompleted, -> { where(completed_at: nil) }
  scope :completed, -> { where.not(completed_at: nil) }
  scope :repeatable, -> { where.not(repeat_after: [nil, 0]) }

  def title_with_timer
    "#{title} #{repeat_after ? "(#{repeat_after})" : "" }"
  end

  def reopen
    if completed_at && completed_at.beginning_of_day + repeat_after.send("days") <= DateTime.now
      self.update completed_at: nil
    end
  end

  def ser
    hash = {
      title: title,
      description: description,
      completed_at: completed_at,
      repeat_after: repeat_after,
      user_ids: user_ids
    }
    hash
  end
end