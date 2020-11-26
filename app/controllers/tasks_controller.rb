class TasksController < ApplicationController
  before_action :set_task,only:[ :show, :edit, :update, :destroy ]
  before_action :authenticate_user, only:[:index, :new, :show, :edit, :update, :destroy]
  def index
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @task = current_user.tasks.search_title(params[:task][:title]).search_status(params[:task][:status]).pagination(params)
      elsif params[:task][:title].present?
        @task = current_user.tasks.search_title(params[:task][:title]).pagination(params)
      else params[:task][:status].present?
        @task = current_user.tasks.search_status(params[:task][:status]).pagination(params)
      end
    elsif
      if params[:sort_expired].present?
        @task = current_user.tasks.sort_deadline.pagination(params)
      elsif params[:sort_priority].present?
        @task = current_user.tasks.sort_priority.pagination(params)
      else
        @task = current_user.tasks.sort_created_at.pagination(params)
      end
    end
  end
  def new
    @task = Task.new
  end
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice:"タスクを登録しました。"
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice:"タスクを編集しました。"
    else
      render :edit
    end
  end
  def destroy
    @task.destroy
    redirect_to tasks_path,notice:"タスクを削除しました。"
  end
  private
  def task_params
    params.require(:task).permit(:title,:content,:deadline,:status,:priority)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
