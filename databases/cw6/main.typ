#import "template.typ": *

#import "@preview/codelst:2.0.2": sourcecode, sourcefile

// #import "diagrams/main.typ" as main_algo

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Базы данных. КМ-6. Триггеры.",
  authors: (
    "Кирш Я.А. ИДз-21-21.",
  ),
)

#show figure: set block(breakable: true)

#outline()

= Задание

Необходимо создать триггер для запрета добавления строки в таблицу `publishers`
при отсутствии соответствующих данных в ссылочной таблице.
Чтобы запретить добавление строки в таблицу `publishers`, если в таблице `pub_info`
нет соответствующих данных, нужно реализовать вставной триггер (`AFTER INSERT`).

= Установка сервера MSSQL

#figure(
  caption: [Установка сервера MSSQL через docker @docker-official. Файл `compose.yaml`],
  sourcefile(
    file: "compose.yaml",
    read("compose.yaml"),
  ),
) <mssql-setup>

= Заполнение базы данных

Я выполнил скрипт, приложенный в разделе 5 'Create Pubs Database'.

= Файл-сценарий SQL

#figure(
  caption: [Файл-сценарий. Файл `script.yaml`],
  sourcefile(
    file: "script.sql",
    read("script.sql"),
  ),
) <sql-script>

Результаты выполнения скрипта выполнен и проверен в программе DBeaver @dbeaver-official.
Скрипт триггера представлен в @sql-script с 22 по 53 строки.

#figure(
  stack(
    dir: ttb, // top-to-bottom
    spacing: 2mm, // space between contents
    image("assets/pub_info_before.png", width: 80%),
    image("assets/publisher_before.png", width: 80%),
  ),
  caption: [Таблицы `publishers` и `pub_info` "до"],
)

#figure(
  image("assets/trigger_error.png", width: 100%),
  caption: [Ошибка вставки записи в таблицу `publishers`],
)

#figure(
  image("assets/trigger_pass.png", width: 80%),
  caption: [Проверка консистентности данных в таблицах `publishers` и `pub_info`],
)

= Выводы

В ходе выполнения данной работы была реализована хранимая процедура
update_publishers для частичного обновления данных в таблице publishers.
Процедура позволяет избирательно изменять различные поля таблицы publishers,
обновляя только те из них, для которых были переданы ненулевые значения.

Основные достоинства разработанной процедуры:
1. Гибкость в обновлении данных - возможность изменять как отдельные поля, так и все поля одновременно
2. Сохранение существующих значений для полей, которые не требуют обновления
3. Обработка ситуаций, когда запись с указанным идентификатором отсутствует в базе данных

Использование хранимых процедур вместо прямых SQL-запросов обеспечивает ряд преимуществ: повышение безопасности за счет контроля доступа к данным, улучшение производительности благодаря предварительной компиляции, а также упрощение сопровождения кода, так как изменения в логике обработки данных требуют внесения правок только в одном месте.
На практических примерах было продемонстрировано, как процедура позволяет эффективно обновлять данные об издателях, с сохранением целостности и согласованности данных в базе.

Полный код проекта представлен в репозитории @uni-db-repo

#bibliography("bibliography.yaml")
