class ToDoTaskController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:submitCheckboxVal,:refreshMonthView,:refreshDayView]

  def index
  end

  def new
    @user = User.find(params[:user_id])
    @AllTasks=@user.to_do_tasks
    @allTaskView=true
  end

  def create
    p params
    @user = User.find(params[:user_id])
    @toDoTask = @user.to_do_tasks.create(todoTask_params)
     @toDoTask.save
    redirect_to new_user_to_do_task_path
  end

  def destroy
    @user = User.find(params[:user_id])
    @toDoTask = @user.to_do_tasks.find(params[:id])
    @toDoTask.destroy
    redirect_to new_user_to_do_task_path
  end

  def submitCheckboxVal
    @todotask = ToDoTask.find(params[:taskID])
    @todotask.status =params[:status]
    @todotask.save
    render :nothing => true
  end

  def displayMonthView
    @user = User.find(params[:user_id])
    @AllTasks=@user.to_do_tasks
    @allTaskView=false

    @day=Date.today.strftime("%B %Y")
  end

  def refreshMonthView


    @user = User.find(params[:user_id])
    @AllTasks=ToDoTask.find_by_sql(["SELECT * FROM to_do_tasks WHERE strftime('%m %Y', date) = ? AND user_id = ?", params[:selectedMonth], params[:user_id]])

    @allTaskView=false
    render :partial => 'to_do_task/formForAllTask'
  end


  def displayDayView
    @user = User.find(params[:user_id])
    @AllTasks=@user.to_do_tasks
    @allTaskView=false

  end

  def refreshDayView
    date=params[:selectedDay].split("/")
    date=date[2]+date[0]+date[1]
    formateddate = DateTime.parse(date.to_s).strftime("%Y-%m-%d 00:00:00.000000")
    p formateddate
    @user = User.find(params[:user_id])
    @AllTasks=ToDoTask.where("date = ? AND user_id = ?", formateddate, params[:user_id])

    @allTaskView=false
    render :partial => 'to_do_task/formForAllTask'
  end

  private
  def todoTask_params
    params.require(:to_do_task).permit(:taskToDO, :date, :status)
  end
end
