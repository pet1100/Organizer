class Task < ApplicationRecord
  has_many :assigned_tasks
  has_many :users, through: :assigned_tasks

  scope :uncompleted, -> { where(completed_at: nil) }
  scope :completed, -> { where.not(completed_at: nil) }
  scope :repeatable, -> { where.not(repeat_after: nil) }

  def title_with_timer
    "#{title} #{repeat_after ? "(#{repeat_after})" : "" }"
  end

  def reopen
    if completed_at && completed_at + repeat_after.send("days") <= DateTime.now
      self.update completed_at: nil
    end
  end
end