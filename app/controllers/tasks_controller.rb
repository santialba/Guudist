# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy]

  def index
    return unless user_signed_in?

    @tasks = Task.filter({ user_id: current_user.id,
                           init_at: Time.now,
                           finish_at: Time.now + 7.days,
                           state: 'to_do',
                           tag_id: params['tag_id'] })
  end

  def show
    render json: {}, status: 401 if !user_signed_in? || current_user.tasks.exclude?(@task)
  end

  def complete
    find_task
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
    params.require(:task).permit(:title, :description, :weight, :deadline_at, tag_ids: [])
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
