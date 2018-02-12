class CreateToDoTasks < ActiveRecord::Migration
  def change
    create_table :to_do_tasks do |t|
      t.string :taskToDO
      t.datetime :date
      t.references :User, index: true

      t.timestamps null: false
    end
    add_foreign_key :to_do_tasks, :Users
  end
end
