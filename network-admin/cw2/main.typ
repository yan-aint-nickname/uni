#import "template.typ": *

#import "@preview/codelst:2.0.2": sourcecode, sourcefile

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Администрирование информационных сетей и систем. КМ-2.",
  authors: (
    "Кирш Я.А. ИДз-21-21.",
  ),
)

#show figure: set block(breakable: true)

#outline()

= Упражнение 1

== Задание 1

#figure(
	image("change_password.jpeg"),
	caption: [Смена пароля пользователя Dmitry Ivanov]
)

== Задание 2

#figure(
	image("user_info_dmitry_ivanov.jpeg"),
	caption: [Информация о пользователе Dmitry Ivanov]
)

== Задание 3

#figure(
	image("user_info_valery_kornishov.jpeg"),
	caption: [Информация о пользователе Valery Kornishov]
)

== Задание 4

#figure(
	image("find_itsecurity_users.jpeg"),
	caption: [Все пользователи подразделения ITSecurity, после выполнения сохраненного запроса `Find ITSecurity Users`]
)

= Упражнение 2

== Задание 1

#figure(
	image("spb1.jpeg"),
	caption: [Созданные пользователи после `CSVDE –I –F C:\Import.csv`]
)

#figure(
	image("spb2.jpeg"),
	caption: [Созданные пользователи после `CSVDE –I –F C:\Import.csv`]
)

== Задание 2
С помощью powershell показать учетные записи пользователей из AD DS

#figure(
	sourcecode(
	```powershell
	Import-Module ActiveDirectory
	Get-ADUser -Filter * -SearchBase "CN=Users,DC=MIC,DC=local" | Format-Table
Name,SamAccountName –A
	```
	),
	caption: [Подключение модуля ActiveDirectory для работы в powershell и команда вывода пользователей],
) <show-users-ad-ds>

#figure(
	image("show_users.jpeg"),
	caption: [Пользователи AD DS после выполнения @show-users-ad-ds]
)

== Задание 3

`Set-ExecutionPolicy AllSigned` у меня сработала, но это не позволило выполнить скрипт, но сработали команды
`Set-ExecutionPolicy RemoteSigned`, `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` и скрипт запустился.

#figure(
	image("roman_veresaev.jpeg"),
	caption: [Результат выполения команды `E:\M02\Labfiles\CreateUser.ps1`],
)

= Индивидуальная часть задания
С помощью средств автоматизации импортировать трёх новых пользователей в подразделение ITSecurity.
Команда должна выполняться за один раз.

#figure(
	sourcefile(file: "ImportUsers.ps1", read("ImportUsers.ps1")),
	caption: [Импортирование пользователей из файла в подразделение ITSecurity]
) <import-users-ps1>

#figure(
	sourcefile(file: "Users.csv", read("Users.csv")),
	caption: [Файл с пользователями для импортирования. Перечислены шахматные гроссмейстеры в порядке убывания рейтинга]
)

#figure(
	image("import_users.jpeg"),
	caption: [Результат работы @import-users-ps1]
)

Полный код проекта представлен в репозитории #link("https://github.com/yan-aint-nickname/uni/network-admin/cw2")
