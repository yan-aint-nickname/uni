#let task_1_main = read("./main.go")

#figure(caption: [Алгоритм программы в `main.go`], raw(task_1_main, lang: "go", block: true))

#let task_1_main_test = read("./main_test.go")
#figure(caption: [Тесты для программы в `main_test.go`], raw(task_1_main_test, lang: "go", block: true))

Для запусков тестов используйте команду в терминале:

```bash
go test
```
