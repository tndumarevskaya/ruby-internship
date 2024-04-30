# Татьяна Николаевна Думаревская

## Запуск HTTP сервиса
Перед запуском сначала создадим наш образ докера из Dockerfile

`docker build -t hw1 .`
- -t - используется для пометки образа именем
- hw1 - имя образа
- . - в конце команды указывается контекст сборки, которым является текущий каталог

Запускаем наш докер файл командой

`docker run --rm -t -p 8080:5678 hw1`
- --rm - удаляем контейнер, когда выходим из него
- -p 8080:5678 - пробрасываем порт 5678 внутри контейнера на порт 8080 на хосте
- hw1 - имя нашего контейнера 


## Описание проекта:

- [http-server.rb](http-server.rb): Этот файл является точкой входа в наше приложение. Он запускает HTTP-сервер и обрабатывает входящие запросы.
- [price_calculator.rb](services/price_calculator.rb): Этот модуль отвечает за вычисление стоимости виртуальных машин на основе переданных параметров, таких как количество CPU, объем оперативной памяти и характеристики жестких дисков.
- [vm_price_service.rb](services/vm_price_service.rb): Этот файл содержит логику обработки запросов и вызова методов для валидации входных данных и вычисления стоимости виртуальных машин.
- [price_loader.rb](loaders/price_loader.rb): Загрузчик цен отвечает за чтение данных о ценах из файла и подготовку их к использованию в приложении.
- [price.rb](data_models/price.rb): Этот файл содержит модель для представления цен составляющих частей виртуальной машины.
- [prices.csv](csv/prices.csv): Файл, в котором содержатся данные о ценах на составлящие части виртуальных машин.

Примеры URL для получения стоимости виртуальных машин:

- http://localhost:8080/vm-price?cpu=32&ram=32&hdd_type=sas&hdd_capacity=1700 - 2560292
- http://localhost:8080/vm-price?cpu=2&ram=4096&hdd_type=sata&hdd_capacity=500&volumes[0][hdd_capacity]=100&volumes[0][hdd_type]=sata&volumes[1][hdd_capacity]=200&volumes[1][hdd_type]=sas - 5426880
- http://localhost:8080/vm-price?cpu=32&ram=32&hdd_type=sas - Missing required parameters
- http://localhost:8080/vm-price?cpu=2&ram=4096&hdd_type=sata&hdd_capacity=500&volumes%5B0%5D%5Bhdd_capacity%5D=100&volumes%5B0%5D%5Bhdd_type%5D=sata&volumes%5B1%5D%5Bhdd_capacity%5D=200 - Missing required parameters for volume