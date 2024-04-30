# frozen_string_literal: true

# Абстрактный класс для всех моделей приложения.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
