#import "template.typ": *

#import "@preview/codelst:2.0.2": sourcecode, sourcefile

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Администрирование информационных сетей и систем. КМ-3. Создание инфраструктуры OU",
  authors: (
    "Кирш Я.А. ИДз-21-21.",
  ),
)

#show figure: set block(breakable: true)

#outline()

= Упражнение 1 Создание группы AD DS

== Задание 1: Создать группы, используя Active Directory – пользователи и компьютеры (Active Directory Users and Computers)

#figure(
	image("assets/exe_1_task_1.jpeg"),
	caption: [Создание групп MIC_ManagersGG, MIC_EmployesGG]
)

== Задание 2: Создайте группу, используя программу командной строки dsadd

#figure(
	image("assets/exe_1_task_2.jpeg"),
	caption: [Создание группы MIC_TrainersGG через `dsadd`]
)

== Задание 3,4: Добавление пользователей во вновь созданные группы, Проверить содержимое группы

#figure(
	image("assets/exe_1_task_34.jpeg"),
	caption: [Проверка участников группы MIC_TrainersGG]
)

= Упражнение 2 Создание иерархии OU

== Задание 1 Создать OU, используя Active Directory – пользователи и компьютеры (Active Directory Users and Computers)

#figure(
	image("assets/exe_2_task_1.jpeg"),
	caption: [Создание новых OU: MIC, Managers, Employes]
)

== Задание 2 Создайте OU, используя программу командной строки dsadd

#figure(
	image("assets/exe_2_task_2.jpeg"),
	caption: [Создание новой OU через утилиту `dsadd`]
)

== Задание 3 Вложение одного ou в структуру другого

#figure(
	image("assets/exe_2_task_3.jpeg"),
	caption: [Перемещение группы Trainers в подразделение MIC]
)

== Задание 4 Перемещение групп в соответствующие подразделения (OUs)

#figure(
	image("assets/exe_2_task_4.jpeg"),
	caption: [Перемещение группы MIC_ManagersGG в подразделение MIC/Managers]
)

== Задание 5 Поиск и перемещение пользователей в подразделение MIC

#figure(
	image("assets/exe_2_task_5.jpeg"),
	caption: [Перемещение пользователей в подразделение на примере MIC/Trainers]
)

= Индивидуальная часть задания
Создать новую универсальную группу в подразделении IT. С помощью средств автоматизации включить в состав этой группы всех пользователей внутри подразделения Managers.

#figure(
	image("assets/exe_personal.jpeg"),
	caption: [Перемещение пользователей из подразделения Managers в NewUniversalGroup]
)

Полный код проекта представлен в репозитории #link("https://github.com/yan-aint-nickname/uni/network-admin/cw3")
