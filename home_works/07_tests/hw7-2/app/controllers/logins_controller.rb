# frozen_string_literal: true

# Контроллер для управления процессом аутентификации пользователей.
class LoginsController < ApplicationController
  # Отображение login страницы.
  #
  # Отрисовывет show.html.erb.
  def show; end

  # Создает новую сессию для пользователя.
  #
  # Перенаправляет на login страницу с оповещением о результате авторизации.
  def create
    redirect_to :login, notice: LoginService.new(params, session).call
  end

  # Уничтожить сессию пользователя.
  #
  # Очищает сеанс входа в систему и перенаправляет на страницу входа с уведомлением о выходе.
  def destroy
    session.delete(:login)
    redirect_to :login, notice: 'Вы вышли'
  end
end
