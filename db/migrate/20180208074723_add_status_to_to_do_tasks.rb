class AddStatusToToDoTasks < ActiveRecord::Migration
  def change
    add_column :to_do_tasks, :status, :string

  end
end
