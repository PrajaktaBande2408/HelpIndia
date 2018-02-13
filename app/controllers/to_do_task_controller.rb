class ToDoTaskController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:submitCheckboxVal,:refreshMonthView,:refreshDayView]

  def index
  end

  def new
    @user = User.find(params[:user_id])
    @AllTasks=@user.to_do_tasks
    @allTaskView="AllView"
  end

  def create
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
    @allTaskView="monthView"
    @day=Date.today.strftime("%B %Y")
  end

  def refreshMonthView
    @user = User.find(params[:user_id])
    @AllTasks=ToDoTask.find_by_sql(["SELECT * FROM to_do_tasks WHERE strftime('%m %Y',    date) = ? AND user_id = ? ORDER BY date ASC", params[:selectedMonth], params[:user_id]])
    @monthView=Hash.new
    @AllTasks.each do |task|
      if !@monthView.has_key? task.date.strftime("%d/%m/%Y")
      @monthView[task.date.strftime("%d/%m/%Y")]= Array.new
      @monthView[task.date.strftime("%d/%m/%Y")].push(task)
      else
        @monthView[task.date.strftime("%d/%m/%Y")].push(task)
      end
    end
      @allTaskView="monthView"
    # respond_to do |format|
    #   format.html{ render :partial => 'to_do_task/formForAllTask'}
    #   format.js
    # end
    render :partial => 'to_do_task/formForAllTask'
  end


  def displayDayView
    @user = User.find(params[:user_id])
    @AllTasks=@user.to_do_tasks
    @allTaskView="dayView"
    @date=Date.today.strftime("%m/%d/%Y")
  end

  def refreshDayView
    date=params[:selectedDay].split("/")
    date=date[2]+"/"+date[0]+"/"+date[1]
    formateddate = DateTime.parse(date.to_s).strftime("%Y-%m-%d 00:00:00.000000")
    @user = User.find(params[:user_id])
    @AllTasks=ToDoTask.where("date = ? AND user_id = ?", formateddate, params[:user_id])
    @allTaskView="dayView"
    render :partial => 'to_do_task/formForAllTask'
  end

  private
  def todoTask_params
    params.require(:to_do_task).permit(:taskToDO, :date, :status)
  end
end
