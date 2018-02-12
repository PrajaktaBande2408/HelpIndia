class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :to_do_tasks, :task_id, :user_id
  end
end
