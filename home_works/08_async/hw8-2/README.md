# Домашняя работа №8-2

## Запуск проекта

Для запуска проекта используйте следующие команды:

- `docker-compose up` - Создает и запускает все сервисы.
- `docker-compose down` - Останавливает и удаляет все сервисы.

### Проверка работы программы
Перед работой необходимо создать базу данных и установить все миграции, а также для простоты заполнения бд можно запустить скрипт seeds:
 - `rails db:create`
 - `rails db:migrate`
 - `rails db:seed`

Для наглядности работы программы:

- `docker-compose up -d rabbitmq` - Запускает RabbitMQ.
- `docker-compose run --rm cloud_app ruby order_status_daemon.rb` - Запускает наш daemon для прослушавания запросов от сервиса, где будет выводиться ответ, что наш запрос сработал и выполнился

## Описание проекта

### API

Для упрощения тестирования создано API с использованием Grape Api и Swagger. Метод `PUT` на странице http://0.0.0.0:3000/swagger используется для изменения статуса заказа. Передаем `id` заказа и новый статус.

- Файл: [orders_api.rb](app/api/grape_api/orders_api.rb)

### Сервис

Создан сервис для выполнения долгой задачи по изменению статуса заказа.

- Файл: [change_order_status_service.rb](app/services/change_order_status_service.rb)

### Демон

Daemon прослушивает отправленные запросы нашим сервисом, чтобы запустить задачу и оповестить об этом.

- Файл: [order_status_daemon.rb](order_status_daemon.rb)

## Пример работы 
Started PUT "/api/orders/100101" for 192.168.65.1


listening

Starting update status of order

..........

The status was created

Changed on failed