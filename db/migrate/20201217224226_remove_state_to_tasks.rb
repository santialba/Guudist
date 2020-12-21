class RemoveStateToTasks < ActiveRecord::Migration[6.0]
  def self.up
    remove_column :tasks, :state
  end
end
