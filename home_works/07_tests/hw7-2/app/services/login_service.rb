# frozen_string_literal: true

# Сервис для аутентификации пользователей.
class LoginService
  attr_reader :params, :session

  def initialize(params, session)
    @params = params
    @session = session
  end

  # Выполняет аутентификацию пользователя, проверяет пароль,
  # изменяет данные сессии и возвращает сообщение об успешной аутентификации.
  def call
    check_password
    modify_session
    message
  end

  private

  # Проверяет пароль пользователя.
  def check_password
    raise if params[:password] != '123'
  end

  # Изменяет данные сессии, устанавливает логин и баланс.
  def modify_session
    session[:login] = params[:login]
    session[:balance] ||= 20_000
  end

  # Формирует приветственное сообщение на основе текущего времени суток и логина пользователя.
  def message
    case Time.zone.now.hour
    when 0..5
      'Доброй ночи, '
    when 6..11
      'С добрым утром, '
    when 12..17
      'Добрый день, '
    when 18..24
      'Добрый вечер, '
    else
      'Здравствуйте, '
    end + params[:login]
  end
end
