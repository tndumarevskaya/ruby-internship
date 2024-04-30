# frozen_string_literal: true

# Контроллер для отображения приветственного сообщения в административной части приложения.
class Admin::WelcomeController < ApplicationController
  # index
  def index
    @welcome_message = 'Welcome to the admin interface!'
  end
end
