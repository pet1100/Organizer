class CreateTask < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.datetime :completed_at
      t.integer :repeat_after
    end
  end
end
