class ToDoTaskController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:submitCheckboxVal,:refreshMonthView,:refreshDayView,:destroybyajax]
  respond_to :html, :json, :xml
  def index
    @user = User.find(params[:user_id])
    @AllTasks=@user.to_do_tasks
    @allTaskView="AllView"
    @msgForNOTODO ="No todos,May be you need to add some."
    # render "to_do_task/index"
    respond_with(@AllTasks)
  end



  def new
    @user = User.find(params[:user_id])
    @AllTasks=@user.to_do_tasks
    @allTaskView="AllView"
    @msgForNOTODO ="No todos,May be you need to add some."
  end

  def create
    @user = User.find(params[:user_id])
    @toDoTask = @user.to_do_tasks.create(todoTask_params)
    @AllTasks=@user.to_do_tasks
    @allTaskView="AllView"
    @msgForNOTODO ="No todos,May be you need to add some."
    @toDoTask.save

    if @toDoTask.save
      redirect_to user_to_do_task_index_path
    else
      render 'new'
    end

  end

  def destroy
    @user = User.find(params[:user_id])
    @toDoTask = @user.to_do_tasks.find(params[:id])
    @toDoTask.destroy
    redirect_to :back
  end

  def destroybyajax
    @user = User.find(params[:user_id])
    @toDoTask = @user.to_do_tasks.find(params[:id])
    @toDoTask.destroy
    render :nothing => true
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
    @msgForNOTODO ="No todos for this month."

    @day=Date.today.strftime("%B %Y")
  end

  def refreshMonthView
    @user = User.find(params[:user_id])
    @AllTasks=ToDoTask.find_by_sql(["SELECT * FROM to_do_tasks WHERE strftime('%m %Y',    date) = ? AND user_id = ? ORDER BY date ASC", params[:selectedMonth], params[:user_id]])
    @monthView=Hash.new
    @AllTasks.each do |task|
      if !@monthView.has_key? task.date.strftime("%m/%d/%Y")
      @monthView[task.date.strftime("%m/%d/%Y")]= Array.new
      @monthView[task.date.strftime("%m/%d/%Y")].push(task)
      else
        @monthView[task.date.strftime("%m/%d/%Y")].push(task)
      end
    end
    @allTaskView="monthView"
    @msgForNOTODO ="No todos for this month."

    render :partial => 'to_do_task/formForAllTask'
  end


  def displayDayView
    @user = User.find(params[:user_id])
    @AllTasks=@user.to_do_tasks
    @allTaskView="dayView"
    @msgForNOTODO ="No todos for this date."

    @date=Date.today.strftime("%m/%d/%Y")
  end

  def refreshDayView
    date=params[:selectedDay].split("/")
    date=date[2]+"/"+date[0]+"/"+date[1]
    formateddate = DateTime.parse(date.to_s).strftime("%Y-%m-%d 00:00:00.000000")
    @user = User.find(params[:user_id])
    @AllTasks=ToDoTask.where("date = ? AND user_id = ?", formateddate, params[:user_id])
    @allTaskView="dayView"

    @msgForNOTODO ="No todos for this date."

    render :partial => 'to_do_task/formForAllTask'
  end

  private
  def todoTask_params
    params.require(:to_do_task).permit(:taskToDO, :date, :status)
  end
end
