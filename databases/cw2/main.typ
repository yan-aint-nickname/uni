#import "template.typ": *

#import "@preview/codelst:2.0.2": sourcecode, sourcefile

// #import "diagrams/main.typ" as main_algo

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "КМ-2. Вариант 20. Тема: Автошкола",
  authors: (
    "Кирш Я.А. ИДз-21-21.",
  ),
)

#show figure: set block(breakable: true)

#outline()

= Файл-сценарий SQL

#figure(
  caption: [Файл-сценарий. Файл `script.yaml`],
  sourcefile(
    file: "script.sql",
    read("script.sql"),
  ),
) <sql-script>

= Генерация фейковых данных

Чтобы не придумывать 33 записи в базе данных, я написал скрипт, который генерирует фейковые данные см. @fake-generators

#figure(
  caption: [Генерация фейковых данных. Файл `fake_data.rb`],
  sourcefile(
    file: "fake_data.rb",
    read("fake_data.rb"),
  ),
) <fake-generators>

Для генерации фейковых данных должен быть установлен интерпретатор `ruby` @ruby-official и библиотека `faker` @faker-official

#figure(
  caption: [Запуск команд для генерации данных скриптом из @fake-generators],
  sourcecode()[```bash
    ruby fake_data.rb students # Генерация студентов
    ruby fake_data.rb instructors # Генерация инструкторов
    ruby fake_data.rb lessons # Генерация уроков
  ```]
) <data-generation>

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
