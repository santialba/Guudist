class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      @tasks = Task.where(:user_id => current_user.id).order("created_at DESC")
    end
  end

  def show
    render json: {}, status: 401 if current_user.tasks.exclude?(@task)
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end

  def complete
    find_task
    @task.update_attribute(:completed_at, Time.now)
    @task.done!
    redirect_to root_path
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :weight)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
