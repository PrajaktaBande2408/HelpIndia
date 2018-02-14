class ToDoTask < ActiveRecord::Base
  belongs_to :User
  validates :taskToDO,:date, presence: true
  # validates :date, presence: true,
  # validate do |ToDoTask|
  #   ToDoTask.errors.add_to_base("Task can not be blank") if ToDoTask.taskToDO.blank?
  #   ToDoTask.errors.add_to_base("date can not be blank") if ToDoTask.date.blank?
  #
  # end
end
