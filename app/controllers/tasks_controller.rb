class TasksController < ApplicationController
  before_action :set_task,only:[ :show, :edit, :update, :destroy ]
  def index
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @task = Task.search_title(params[:task][:title]).search_status(params[:task][:status]).pagenation(params)
      elsif params[:task][:title].present?
        @task = Task.search_title(params[:task][:title]).pagenation(params)
      elsif params[:task][:status].present?
        @task = Task.search_status(params[:task][:status]).pagenation(params).pagenation(params)
      else
        @task = Task.sort_created_at.pagenation(params)
      end
    else
      if params[:sort_expired].present?
        @task = Task.all.sort_deadline.pagenation(params)
      elsif params[:sort_priority].present?
        @task = Task.all.sort_priority.pagenation(params)
      else
        @task = Task.sort_created_at.pagenation(params)
      end
    end
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
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
