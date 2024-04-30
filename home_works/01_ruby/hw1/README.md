# Татьяна Николаевна Думаревская

## Запуск программы

Входной файл программы - `index.rb`. Я разрабатывала и тестировала свой проект локально на своей машине в VS Code, поэтому для запуска проекта я использовала команду `ruby index.rb`. Однако, я также провела тестирование на виртуальной машине, запустив приложение с помощью Docker команды: `docker run --rm -it -v $(pwd):/hw1 -w /hw1 ruby:3.0 ruby index.rb`. 

## Краткое описание проекта

Мой проект включает следующие основные сущности предметной области:
- Виртуальная машина (VM)
- Цена (Price)
- Объем (Volume)

А также вспомогательные сущности:
- Получение данных о виртуальных машинах (VMLoader)
- Получение данных о ценах (PriceLoader)
- Получение данных о дополнительных дисках (VolumeLoader)
- Создание отчета (Report)
- Печать отчета в STDOUT (ReportPresenter)

Все классы имеют поля согласно заданию, однако, я добавила дополнительные методы и поля:

- Данные о дополнительных дисках записываются в поле `volumes` класса `VM`. `volumes` представляет собой массив объектов класса `Volume`.
- `VMLoader` имеет два метода для получения машин. Первый возвращает машины согласно их типу диска, второй - согласно типу дополнительного диска.
- Модуль `Report` содержит методы для создания различных отчетов: 
    - `expensive_vm(n)` - создает отчет с n самыми дорогими машинами
    - `cheap_vm(n)` - создает отчет с n самыми дешевыми машинами
    - `big_volume(n, type)` - выбирает n машин с самым большим объемом диска, учитывая переданный тип диска
    - `additional_volume_number(n, hdd_type)` - выбирает n машин с наибольшим количеством дополнительных дисков, учитывая переданный тип диска
    - `additional_volume_capacity(n, hdd_type)` - выбирает n машин с наибольшей суммой объемов дополнительных дисков, учитывая переданный тип диска
    - `calculate_price` - вычисляет сумму для каждой машины
    - `calculate_additional_volume` - вычисляет объем дополнительных дисков, учитывая тип диска
- Метод модуля `ReportPresenter` принимает отчет и аргумент, который указывает по какому параметру составлялся отчет ('Price', 'HDD capacity', 'HDD number', 'Additional HDD num', "Additional HDD capacity"), для более понятного отображения данных, а также может принимать тип диска, если это необходимо.