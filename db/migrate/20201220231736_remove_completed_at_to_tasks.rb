class RemoveCompletedAtToTasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :completed_at
  end
end
