class ApplicationController < ActionController::Base
  
  # Проверяет, вошел ли пользователь в систему
  def logged_in?
    session[:login].present?
  end

end