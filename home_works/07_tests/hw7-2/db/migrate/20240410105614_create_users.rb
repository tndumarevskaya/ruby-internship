# frozen_string_literal: true

# Эта миграция создает таблицу пользователей.
class CreateUsers < ActiveRecord::Migration[6.1]
  # Создание таблицы пользователей.
  #
  # Создает таблицу с именем 'users' с колонками:
  # - first_name: строка, представляющая имя пользователя
  # - last_name: строка, представляющая фамилию пользователя
  # - balance: целое число, представляющее баланс пользователя
  # - timestamps: автоматически сгенерированные метки времени для создания и обновления записей
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :balance

      t.timestamps
    end
  end
end
