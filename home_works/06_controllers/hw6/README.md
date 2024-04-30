# Думаревская Татьяна Николаевна 

## Домашняя работа №6

### Запуск проекта 
`docker-compose up` - Создание и запуск сервиса

`docker-compose down` - Остановка и удаление сервисов

### Описание проекта 
Проект состоит из двух сервисов 
1. cloud_app - приложения для создания заказов ВМ
2. price_app - прилоежние для подсчета цены ВМ по переданным параметрам

### Описание метода `check`
Метод `check` в файле [orders_controller.rb](./app/controllers/orders_controller.rb), реализованный в cloud_app, предназначен для определения возможности совершить покупку ВМ пользователем. Пользователь должен быть авторизован для выполнения этого действия.

### Проверка авторизации
Для проверки авторизации необходимо сначала выполнить вход, перейдя по следующему URL-адресу:

* localhost:3000/login

Необходимо авторизоваться, используя пароль ("123") и любой логин.

Для проверки авторизирован ли пользователь в файле [application_controller.rb](./app/controllers/application_controller.rb) мы определили метод для проверки находится в данной сессии пользователь.

Если этого не выполнить, то по пути 
- http://localhost:3000/orders/check?check%5Bos%5D=linux&check%5Bcpu%5D=1&check%5Bram%5D=2&check%5Bhdd_type%5D=sata&check%5Bhdd_capacity%5D=11 : Возвращает {"result":false,"message":"Войдите в систему, пожалуйста."}

### OrderService
В файле [order_service.rb](./app/services/order_service.rb) реализованы бизнес логика заказов.

### Примеры URL для проверки работы метода:
1. Проверка успешного заказа
- http://localhost:3000/orders/check?check%5Bos%5D=linux&check%5Bcpu%5D=1&check%5Bram%5D=2&check%5Bhdd_type%5D=sata&check%5Bhdd_capacity%5D=11 : Возвращает {"result":true,"total":14982,"balance":1790252,"balance_after_transaction":1775270}
2. Проверка неправильно указанного параметра или пропушенного
- http://localhost:3000/orders/check?check%5Bos%5D=lix&check%5Bcpu%5D=1&check%5Bram%5D=2&check%5Bhdd_type%5D=sata&check%5Bhdd_capacity%5D=11 : Возвращает {"result":false,"message":"Параметры не совпадают с возможными заказами."}
3. Если возникнут какие-то ошибки на внешних системах : Возвращает {"result":false,"message":"Ошибка доступа к внешней системе."}
