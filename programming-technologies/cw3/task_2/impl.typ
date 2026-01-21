
Для просмотра кода алгоритма из main.py лучше использовать marimo @marimo.
Для работы с репозиторием я использую pixi @arts_pixi.
Для обработки данных из файла input.csv я использую polars @polars.

Результаты работы программы представлены в @task_2_01, @task_2_02 и @task_2_03

#figure(image("../assets/task_2/01.png"), caption: [Загрузка данных из файла]) <task_2_01>

#figure(image("../assets/task_2/02.png"), caption: [Сортировка списка участников бригады]) <task_2_02>

#figure(image("../assets/task_2/03.png"), caption: [Сортировка списка участников бригады]) <task_2_03>

#figure(caption: [Код программы], ```python
# Загружаем модуль/фреймворк "polars" для работы с данными
import polars as pl
# Читаем из файла "input.cvs" данные с разделителем ";"
data = pl.read_csv("input.csv", separator=";")
# Выводим 5 первых записей
data.head(5)
# Сортируем по номеру бригады в порядке возрастания, а по зарплате в порядке убывания
data_sorted = data.sort(["team", "salary"], descending=[False, True])
# Записываем результат в файл
data_sorted.write_csv("input_sorted.csv", separator=";")
# Находим среднюю зарплату по всем рабочим
mean = data['salary'].mean()
# Определяем для каждой бригады кол-во рабочих, имеющих зарплату ниже средней
# 1. группируем по столбцу 'team'
# 2. определяем новый столбец 'lt' (less-than)
# 3. фильтруем по столбцу 'salary' значения меньше 'mean'
# 4. считаем кол-во с помощью метода 'count()'
data.group_by('team').agg(lt=pl.col('salary').filter(pl.col("salary") < mean).count())
```)

#let data = read("./input.csv")
#figure(caption: [Файл с бригадами `input.csv`], raw(data, lang: "csv", block: true))

Для запуска программы в интерактивном режиме используйте команду в терминале:
```bash
marimo edit main.py
```
