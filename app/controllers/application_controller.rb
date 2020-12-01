class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def authenticate_user
    unless logged_in?
      flash[:danger] = 'ログインが必要です。'
      redirect_to new_session_path
    end
  end
  def ensure_current_user_task_check
    unless current_user.id == @task.user_id
      flash[:danger] = '権限がありません。'
      redirect_to tasks_path
    end
  end
  def ensure_current_user_label_check
    unless current_user.id == @label.user_id
      flash[:danger] = '権限がありません。'
      redirect_to tasks_path
    end
  end
  def ensure_current_user
    if logged_in?
      unless current_user.id == params[:id].to_i
        flash[:danger] = '権限がありません。'
        redirect_to tasks_path
      end
    else
      flash[:danger] = 'ログインが必要です。'
      redirect_to new_session_path
    end
  end
  def ensure_admin_user
    if logged_in?
      unless current_user.admin?
        redirect_to tasks_path
        flash[:danger] = 'このユーザーにはアクセス権限がありません。'
      end
    else
      flash[:danger] = 'ログインが必要です。'
      redirect_to new_session_path
    end
  end
end
