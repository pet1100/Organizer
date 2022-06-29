class CreateAssignedTask < ActiveRecord::Migration[7.0]
  def change
    create_table :assigned_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
    end
  end
end
