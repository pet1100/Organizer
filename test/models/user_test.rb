require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.create username: "test", password: "123", last_refreshed: Time.now
  end

  test "test should reopen task" do
    Timecop.freeze(202, 10, 5, 3)
    @user.update last_refreshed: 2.hours.ago
    @user.tasks << Task.create(title: "test titel 1", completed_at: 5.hour.ago, repeat_after: 1)
    @user.tasks << Task.create(title: "test titel 2", completed_at: 4.hour.ago, repeat_after: 1)
    @user.tasks << Task.create(title: "test titel 3", completed_at: 3.hour.ago, repeat_after: 1)

    if @user.refreshable?
      @user.tasks.each do |task|
        task.reopen
      end
    end

    assert_equal 2, Task.where(completed_at: nil).count
    assert_equal 1, Task.where.not(completed_at: nil).count
  end
end
