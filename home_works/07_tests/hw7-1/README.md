# Думаревская Татьяна Николаевна 

## Домашняя работа №7

### Запуск проекта 
- `docker-compose up` - Создание и запуск сервиса
- `docker-compose down` - Остановка и удаление сервисов

### Запуск тестов
- `docker-compose run --rm cloud_app bash` - Запускает контейнер с приложением в bash-сессии
- `rspec` - Запускает тесты для приложения

### Описание проекта 
В ходе выполнения домашней работы были написаны тесты для метода `check` в файле [orders_controller_spec.rb](spec/controllers/orders_controller_spec.rb). Эти тесты покрывают различные сценарии работы метода `check` в контроллере [orders_controllers.rb](app/controllers/orders_controller.rb).

Тестирование метода `check` позволяет убедиться в корректности его работы и обработке различных ситуаций, таких как авторизация пользователя, проверка параметров запроса, проверка конфигурации и баланса пользователя, а также обработка ситуации, когда сервер недоступен.