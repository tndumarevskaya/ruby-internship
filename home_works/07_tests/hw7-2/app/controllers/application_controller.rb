# frozen_string_literal: true

# Базовый контроллер, от которого наследуются все остальные контроллеры в приложении.
class ApplicationController < ActionController::Base
  # Проверяет, вошел ли пользователь в систему
  def logged_in?
    session[:login].present?
  end
end
