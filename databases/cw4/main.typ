#import "template.typ": *

#import "@preview/codelst:2.0.2": sourcecode, sourcefile

// #import "diagrams/main.typ" as main_algo

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "КМ-4. Вариант 20. Тема: Автошкола",
  authors: (
    "Кирш Я.А. ИДз-21-21.",
  ),
)

#show figure: set block(breakable: true)

#outline()

= Файл-сценарий SQL

#figure(
  caption: [Файл-сценарий. Файл `script.sql`],
  sourcefile(
    file: "script.sql",
    read("script.sql"),
  ),
) <sql-script>

Данные для базы данных были взяты из КМ2 и были сгенерированны.

= Установка сервера MSSQL

#figure(
  caption: [Установка сервера MSSQL через docker @docker-official. Файл `compose.yaml`],
  sourcefile(
    file: "compose.yaml",
    read("compose.yaml"),
  ),
) <mssql-setup>

Полный код проекта представлен в репозитории @uni-db-repo

#bibliography("bibliography.yaml")
