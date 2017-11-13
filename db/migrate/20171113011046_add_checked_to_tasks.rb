class AddCheckedToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :checked, :boolean, default: false
  end
end
