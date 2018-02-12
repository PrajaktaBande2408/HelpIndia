class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def change
    def up
      change_column :to_do_tasks, :date, :date
    end

    def down
      change_column :to_do_tasks, :date, :datetime
    end
  end
end
