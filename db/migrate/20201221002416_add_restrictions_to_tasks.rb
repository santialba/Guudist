class AddRestrictionsToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :title, :string, null: false
    change_column :tasks, :weight, :integer, null: false
    change_column :tags, :name, :string, null: false
  end
end
