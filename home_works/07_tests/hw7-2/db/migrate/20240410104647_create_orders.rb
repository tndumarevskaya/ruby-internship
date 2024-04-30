# frozen_string_literal: true

# Эта миграция создает таблицу заказов.
class CreateOrders < ActiveRecord::Migration[6.1]
  # Создание таблицы заказов.
  #
  # Создает таблицу с именем 'orders' с колонками:
  # - name: строка, представляющая название заказа
  # - status: целое число, представляющее статус заказа
  # - cost: целое число, представляющее стоимость заказа
  # - timestamps: автоматически сгенерированные метки времени для создания и обновления записей
  def change
    create_table :orders do |t|
      t.string :name
      t.integer :status
      t.integer :cost

      t.timestamps
    end
  end
end
