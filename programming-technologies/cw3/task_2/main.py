# /// script
# requires-python = ">=3.14"
# dependencies = [
#     "marimo",
#     "pyzmq",
# ]
# ///

import marimo

__generated_with = "0.19.4"
app = marimo.App(width="medium")


@app.cell
def _():
    # Загружаем модуль/фреймворк "polars" для работы с данными
    import polars as pl
    return (pl,)


@app.cell
def _(pl):
    # Читаем из файла "input.cvs" данные с разделителем ";"
    data = pl.read_csv("input.csv", separator=";")
    return (data,)


@app.cell
def _(data):
    # Выводим 5 первых записей
    data.head(5)
    return


@app.cell
def _():
    # Импортируем модуль для правильного отображения md ниже
    import marimo as mo
    return (mo,)


@app.cell
def _(mo):
    mo.md(rf"""
    ### Вывести список рабочих по бригадам, расположив фамилии в списках в порядке убывания зарплаты.
    """)
    return


@app.cell
def _(data):
    # Сортируем по номеру бригады в порядке возрастания, а по зарплате в порядке убывания
    data_sorted = data.sort(["team", "salary"], descending=[False, True])

    # Записываем результат в файл
    data_sorted.write_csv("input_sorted.csv", separator=";")
    data_sorted
    return


@app.cell
def _(mo):
    mo.md(r"""
    ### Определить среднюю зарплату по всем рабочим и подсчитать для каждой бригады количество рабочих, имеющих зарплату ниже средней
    """)
    return


@app.cell
def _(data, pl):
    # Находим среднюю зарплату по всем рабочим
    mean = data['salary'].mean()
    # Определяем для каждой бригады кол-во рабочих, имеющих зарплату ниже средней
    # 1. группируем по столбцу 'team'
    # 2. определяем новый столбец 'lt' (less-than)
    # 3. фильтруем по столбцу 'salary' значения меньше 'mean'
    # 4. считаем кол-во с помощью метода 'count()'
    data.group_by('team').agg(lt=pl.col('salary').filter(pl.col("salary") < mean).count())
    return


if __name__ == "__main__":
    app.run()
