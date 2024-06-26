#import "template.typ": *

#import "@preview/codelst:2.0.1": sourcecode, sourcefile

// #import "diagrams/main.typ" as main_algo

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Форматы хранения и передачи данных XML и JSON",
  authors: (
    "Кирш Я.А. ИДз-21-21.",
  ),
)

#show figure: set block(breakable: true)

#outline()

= Форматы хранения и передачи данных XML и JSON. Основные понятия

XML (eXtensible Markup Language) и JSON (JavaScript Object Notation) — два популярных формата для хранения и передачи данных в веб-приложениях и между системами. XML представляет собой язык разметки, который использует теги для описания структуры данных, в то время как JSON — это текстовый формат, использующий пары "ключ-значение" для представления данных. Оба формата широко используются благодаря своей гибкости и возможности легко передавать данные между различными платформами и языками программирования.

= Области применения

XML и JSON применяются в самых разных областях, включая веб-разработку, обмен данными между серверами и клиентами, конфигурацию программного обеспечения и многое другое.

- *XML*:
  - Веб-службы (SOAP)
  - Конфигурационные файлы (например, для Java приложений)
  - Документы и электронные публикации

- *JSON*:
  - Веб-API (RESTful сервисы)
  - Конфигурационные файлы (например, для JavaScript и других языков)
  - Хранение и передача данных в NoSQL базах данных (например, MongoDB)

= Структура и наборы правил. Примеры кода

== XML

XML использует теги для обозначения элементов данных и их вложенности. Вот простой пример XML-документа:

```xml
<note>
  <to>Elena</to>
  <from>Ivan</from>
  <heading>Reminder</heading>
  <body>Please buy me a coffee!</body>
</note>
```

Основные правила XML:

- Все элементы должны иметь закрывающий тег.
- Теги чувствительны к регистру.
- Документ должен иметь один корневой элемент.

== JSON

JSON представляет данные в формате "ключ-значение". Вот пример JSON-документа:

```json
{
  "note": {
    "to": "Elena",
    "from": "Ivan",
    "heading": "Reminder",
    "body": "Please buy me a coffee!"
  }
}
```

Основные правила JSON:

- Данные представляются в виде пар "ключ-значение".
- Ключи заключаются в двойные кавычки.
- Строки также заключаются в двойные кавычки.
- Объекты разделяются запятыми.

Так же стоит отметить официальный сайт с грамматикой, где подробнее описаны правила с иллюстрациями @json-official

В качестве примера использования и примеров кода я написал небольшой web-сервис на языке программирования Go @golang-official.
// Полный код проекта.

#figure(
  caption: "Файл с web-сервисом",
  sourcefile(
    file: "main.go",
    read("main.go"),
  )
)

Для запуска программы необходимо выполнить и установленные компилятор Go, который можно скачать на официальном сайте @golang-official. Версия языка должна быть не ниже 1.22.3
```bash
go run main.go
```
После запуска веб-серве будет доступен на 'localhost:8080'

Для проверки работы сервиса необходимо запустить утилиту командной строки curl @curl-official

Для получения ответа в формате xml
```bash
curl --request GET \
  --url 'http://localhost:8080/hello?type=xml&value=world'
```
Ответ от сервера
```xml
<GreetingResp><greeting to="Hello world"></greeting></GreetingResp>
```

Для получения ответа в формате json
```bash
curl --request GET \
  --url 'http://localhost:8080/hello?type=json&value=world'
```
Ответ от сервера
```json
{"greeting":{"to":"Hello world"}}
```


= Преимущества и недостатки

== XML

*Преимущества*:

- Гибкость: позволяет создавать сложные иерархические структуры данных.
- Стандартизация: поддерживается множеством стандартов и спецификаций (например, XSLT, XPath).
- Валидация: поддержка схем (XSD) для проверки структуры и содержания данных.

*Недостатки*:

- Объемность: данные в XML могут занимать больше места по сравнению с другими форматами.
- Сложность обработки: требует больше ресурсов для парсинга и обработки.

== JSON

*Преимущества*:

- Легкость: более компактный и легкий для чтения и записи формат.
- Быстрота обработки: требует меньше ресурсов для парсинга по сравнению с XML.
- Совместимость с JavaScript: легко интегрируется в веб-приложения.

*Недостатки*:

- Ограниченная поддержка схем: менее строгие правила для валидации структуры данных.
- Отсутствие комментариев: формат не поддерживает включение комментариев в данные.

= Альтернативы

Кроме XML и JSON, существуют и другие форматы для хранения и передачи данных:

/ YAML: (YAML Ain't Markup Language): человекочитаемый формат, часто используемый для конфигурационных файлов.
/ CSV: (Comma-Separated Values): простой текстовый формат для табличных данных.
/ Protobuf: (Protocol Buffers): двоичный формат, разработанный Google для эффективной сериализации структур данных.
/ TOML: (Tom's Obvious, Minimal Language): формат для конфигурационных файлов, который отличается простотой синтаксиса и удобством для человека.

Помимо широко известных форматов, существуют менее популярные, но все же полезные альтернативы для хранения и передачи данных:

/ BSON: (Binary JSON): бинарный формат сериализации данных, использующийся в MongoDB, обеспечивающий быструю обработку и меньший размер данных по сравнению с JSON.
/ MessagePack: бинарный формат сериализации данных, который эффективнее по размеру и скорости по сравнению с JSON.
/ Avro: формат сериализации данных от Apache, используемый в проектах Hadoop. Он поддерживает эволюцию схем данных и эффективное сжатие.
/ CBOR: (Concise Binary Object Representation): бинарный формат, предназначенный для компактного представления данных.
/ Thrift: формат и фреймворк от Apache для разработки и сериализации межплатформенных сервисов.
/ UBJSON: (Universal Binary JSON): формат, направленный на предоставление бинарной версии JSON.
/ FlatBuffers: формат сериализации данных, разработанный Google, ориентированный на высокую производительность и минимальные затраты на десериализацию.
/ Ion: формат данных, разработанный Amazon, который сочетает в себе характеристики JSON и BSON с дополнительными возможностями, такими как поддержка схем и аннотаций.
/ Smile: бинарный формат, основанный на JSON, предназначенный для компактного и быстрого хранения и передачи данных.

Каждый из этих форматов имеет свои уникальные особенности и области применения, что позволяет выбрать наиболее подходящий в зависимости от требований конкретного проекта.

Эти альтернативы могут быть предпочтительнее в зависимости от конкретных требований проекта и условий использования.

#bibliography("bibliography.yaml")
