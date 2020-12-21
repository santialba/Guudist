class AddIndexTableTasksTags < ActiveRecord::Migration[6.0]
  def change
    add_index :tags_tasks, [:tag_id, :task_id], unique: true
  end
end
