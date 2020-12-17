class TasksController < ApplicationController
  before_action :find_task, only: [:show]

  def index
    @tasks = Task.all.order("created_at DESC")
  end

  def show

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(item_params)
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
