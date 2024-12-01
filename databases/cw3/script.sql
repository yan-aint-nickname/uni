USE [master];

-- Пример использования системных представлений - получение списка существующих баз данных
IF NOT EXISTS (
    SELECT
        name
    FROM
        sys.databases
    WHERE
        name = 'test_work_three'
) BEGIN CREATE
DATABASE test_work_three END;

USE [test_work_three];

CREATE TABLE students (
  id BIGINT PRIMARY KEY IDENTITY(1, 1),
  first_name NVARCHAR(50) NOT NULL,
  last_name NVARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(15),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
);

CREATE TABLE instructors (
  id BIGINT PRIMARY KEY IDENTITY(1, 1),
  first_name NVARCHAR(50) NOT NULL,
  last_name NVARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(15),
  license_number NVARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
);

CREATE TABLE lesson_statuses (STATUS NVARCHAR (40) PRIMARY KEY,);

INSERT INTO
  lesson_statuses (STATUS)
VALUES
  ('scheduled'),
  ('initial'),
  ('pay_error'),
  ('pay_success'),
  ('passed'),
  ('cancelled_by_student'),
  ('cancelled_by_instructor'),
  ('missed_by_student'),
  ('missed_by_instructor');

CREATE TABLE lessons (
  id BIGINT PRIMARY KEY IDENTITY(1, 1),
  student_id BIGINT,
  FOREIGN KEY (student_id) REFERENCES students(id),
  instructor_id BIGINT,
  FOREIGN KEY (instructor_id) REFERENCES instructors(id),
  topic VARCHAR(300),
  STATUS NVARCHAR(40),
  FOREIGN KEY (STATUS) REFERENCES lesson_statuses(STATUS),
  scheduled_at DATETIME,
  created_at DATETIME DEFAULT GETDATE (),
  updated_at DATETIME DEFAULT GETDATE (),
);

INSERT INTO
  students (first_name, last_name, email, phone)
VALUES
  (
    'Epifania',
    'Mosciski',
    'epifaniamosciski@wintheiser.test',
    '+416443608849'
  ),
  (
    'Maye',
    'Kozey',
    'mayekozey@hammes.test',
    '+541372344001'
  ),
  (
    'Ressie',
    'Gerlach',
    'ressiegerlach@grimes-spinka.test',
    '+919040616187'
  ),
  (
    'Asa',
    'Donnelly',
    'asadonnelly@rice-adams.example',
    '+866096420928'
  ),
  (
    'Edward',
    'Feil',
    'edwardfeil@koch-ullrich.example',
    '+76844766262'
  ),
  (
    'Tobias',
    'Wisozk',
    'tobiaswisozk@sawayn.test',
    '+928626907859'
  ),
  (
    'Viviana',
    'Terry',
    'vivianaterry@connelly.example',
    '+18053676267'
  ),
  (
    'Dorris',
    'Koelpin',
    'dorriskoelpin@koepp.example',
    '+314992603936'
  ),
  (
    'Reva',
    'Hamill',
    'revahamill@murray.test',
    '+18710873594'
  ),
  (
    'Elidia',
    'Hoeger',
    'elidiahoeger@gerlach.test',
    '+866179433605'
  ),
  (
    'Missy',
    'D''Amore',
    'missydamore@moore-kshlerin.example',
    '+821658284387'
  );

INSERT INTO
  instructors (
    first_name,
    last_name,
    email,
    phone,
    license_number
  )
VALUES
  (
    'Levi',
    'Lubowitz',
    'levilubowitz@lebsack.example',
    '+634750537222',
    '06232199219'
  ),
  (
    'Ezekiel',
    'Bartell',
    'ezekielbartell@heller-gleichner.test',
    '+657273029952',
    '02578482403'
  ),
  (
    'Georgette',
    'D''Amore',
    'georgettedamore@barrows.test',
    '+648514012472',
    '01978450702'
  );

INSERT INTO
  lessons (
    student_id,
    instructor_id,
    topic,
    STATUS,
    scheduled_at
  )
VALUES
  (
    '11',
    '2',
    'Consectetur nulla porro nihil. Praesentium enim earum repellendus?',
    'pay_error',
    '2024-10-27 12:33:20'
  ),
  (
    '7',
    '3',
    'Vitae accusamus qui non. Laboriosam illo qui voluptatem?',
    'cancelled_by_instructor',
    '2024-10-28 12:33:20'
  ),
  (
    '2',
    '3',
    'Vitae officiis sit placeat. Unde ex rerum pariatur?',
    'passed',
    '2024-10-29 12:33:20'
  ),
  (
    '5',
    '2',
    'Amet dolorum pariatur et. Et cumque dolore quisquam?',
    'pay_success',
    '2024-10-30 12:33:20'
  ),
  (
    '11',
    '1',
    'Quia optio veniam tempore. Eum cumque et ipsum?',
    'missed_by_student',
    '2024-10-31 12:33:20'
  ),
  (
    '10',
    '1',
    'A modi voluptas harum. Nihil quos aut aliquid?',
    'scheduled',
    '2024-11-01 12:33:20'
  ),
  (
    '11',
    '1',
    'Consequatur quos neque qui. Mollitia numquam voluptatem sed?',
    'cancelled_by_student',
    '2024-11-02 12:33:20'
  ),
  (
    '2',
    '3',
    'Dolores et impedit suscipit. Voluptates ut architecto voluptatem?',
    'cancelled_by_instructor',
    '2024-11-03 12:33:20'
  ),
  (
    '4',
    '3',
    'Maiores odio facere cum. Ipsum aut occaecati et?',
    'scheduled',
    '2024-11-04 12:33:20'
  ),
  (
    '2',
    '3',
    'Et eos ratione dolores. Dolorum nihil ipsum et?',
    'scheduled',
    '2024-11-05 12:33:20'
  ),
  (
    '3',
    '3',
    'Ut sint eos repellat. Et iusto consequatur et?',
    'missed_by_instructor',
    '2024-11-06 12:33:20'
  ),
  (
    '8',
    '1',
    'Tempore aut debitis non. Dolores voluptatem non et?',
    'cancelled_by_student',
    '2024-11-07 12:33:20'
  ),
  (
    '10',
    '1',
    'Provident commodi non quasi. Odit omnis quas corporis?',
    'initial',
    '2024-11-08 12:33:20'
  ),
  (
    '8',
    '1',
    'Provident doloribus molestiae dolorem. Voluptatem neque alias nostrum?',
    'scheduled',
    '2024-11-09 12:33:20'
  ),
  (
    '4',
    '1',
    'Dolor assumenda voluptatem qui. Voluptas maiores explicabo dolorem?',
    'passed',
    '2024-11-10 12:33:20'
  ),
  (
    '8',
    '1',
    'Fuga voluptatem earum voluptatum. Labore dicta qui est?',
    'missed_by_student',
    '2024-11-11 12:33:20'
  ),
  (
    '9',
    '1',
    'Doloribus sunt est nisi. Et voluptatum officiis debitis?',
    'cancelled_by_instructor',
    '2024-11-12 12:33:20'
  ),
  (
    '2',
    '1',
    'Sed voluptatem quasi assumenda. Est et distinctio esse?',
    'scheduled',
    '2024-11-13 12:33:20'
  ),
  (
    '10',
    '1',
    'Praesentium cumque laborum velit. Praesentium et itaque blanditiis?',
    'scheduled',
    '2024-11-14 12:33:20'
  ),
  (
    '5',
    '3',
    'Repudiandae voluptas reiciendis dolores. Aliquid aliquam modi sunt?',
    'scheduled',
    '2024-11-15 12:33:20'
  ),
  (
    '7',
    '1',
    'Omnis occaecati reiciendis at. Saepe et quibusdam commodi?',
    'cancelled_by_student',
    '2024-11-16 12:33:20'
  ),
  (
    '4',
    '1',
    'Est voluptas quas sunt. Et nisi aut harum?',
    'pay_success',
    '2024-11-17 12:33:20'
  );

ALTER TABLE
  students
ADD
  CONSTRAINT uq_students_email UNIQUE (email);

ALTER TABLE
  instructors
ADD
  CONSTRAINT uq_instructors_email UNIQUE (email);

-- Простые индексы
CREATE INDEX idx_lessons_scheduled_at ON lessons(scheduled_at);

CREATE INDEX idx_instructors_license_number ON instructors(license_number);

CREATE INDEX idx_students_email ON students(email);

CREATE INDEX idx_instructors_email ON instructors(email);

-- Составной индекс
CREATE INDEX idx_lessons_instructor_scheduled ON lessons(instructor_id, scheduled_at);

-- Прежде чем удалять записи из таблицы lessons, нужно изменить тип FK для звязи students -> lessons
-- и сделать эту свзяь nullable
ALTER TABLE
  lessons
ALTER COLUMN
  student_id BIGINT NULL;

-- Проставлять null в стобце student_id при удалении записей из таблицы lessons
ALTER TABLE
  lessons
ADD
  CONSTRAINT FK_Lessons_Students FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE
SET
  NULL;

-- Найдем всех студентов со статусами pay_error и cancelled_by_student,
-- как будто они передумали заниматься в автошколе и создадим представление
CREATE VIEW pay_error_students AS
SELECT
    s.id AS student_id,
    l.id AS lesson_id,
    l.status AS lesson_status,
    concat(
        s.first_name, ' ', s.last_name) AS student_name
FROM
    lessons l
    JOIN students s ON l.student_id = s.id
WHERE
    l.status IN(
        'cancelled_by_student', 'pay_error'
);

-- Выведем все записи из представления 'pay_error_students'
select * from pay_error_students;

-- Изменим представление 'pay_error_students' - добавим номер телефона
ALTER VIEW pay_error_students AS
SELECT
    s.id AS student_id,
    l.id AS lesson_id,
    l.status AS lesson_status,
    concat(s.first_name, ' ', s.last_name) AS student_name,
    s.phone AS student_phone
FROM
    lessons l
    JOIN students s ON l.student_id = s.id
WHERE
    l.status IN ('cancelled_by_student', 'pay_error');

-- Выведеем все записи из измененного представления 'pay_error_students'
select * from pay_error_students;

-- Удалим представление
DROP VIEW pay_error_students;

-- Создадим представление со студентами, которые уже сходили на занятие
create view students_to_call_with_finished_lessons AS
SELECT
    s.id AS student_id,
    l.id AS lesson_id,
    l.status AS lesson_status,
    concat(s.first_name, ' ', s.last_name) AS student_name,
    s.phone AS student_phone
FROM
    lessons l
    JOIN students s ON l.student_id = s.id
WHERE
    l.status IN ('passed');

-- Обновление данных в представлении
update students_to_call_with_finished_lessons set student_phone = '+741372344001' where student_name = 'Maye Kozey';

drop view students_to_call_with_finished_lessons;

-- Удалние записей из представления и таблицы
create view students_odd as
select * from students where (id % 2) = 0;

select * from students_odd;

delete from students_odd where (id % 3) = 0;

-- Добавление данных в представление
INSERT INTO
    students_odd (first_name, last_name, email, phone)
VALUES
    ('Ivan', 'Ivanov', 'ivanov.ivan@email.com', '+79999999900');

-- Удаление представления
drop view students_odd;
