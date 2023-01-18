class AddPrioritizeToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :priority, :integer
    add_index :tasks, :priority
  end
end
