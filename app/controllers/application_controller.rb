class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def authenticate_user
    if logged_in?
      # unless current_user.id = @task.user_id
      #   flash[:danger] = '権限がありません。'
      #   redirect_to tasks_path
    else
      flash[:danger] = 'ログインが必要です。'
      redirect_to new_session_path
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
end
