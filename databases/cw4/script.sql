USE [master];

IF NOT EXISTS (
    SELECT
        name
    FROM
        sys.databases
    WHERE
        name = 'test_work_four'
) BEGIN CREATE
DATABASE test_work_four END;

USE [test_work_four];

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

CREATE INDEX idx_lessons_scheduled_at ON lessons(scheduled_at);

CREATE INDEX idx_instructors_license_number ON instructors(license_number);

CREATE INDEX idx_students_email ON students(email);

CREATE INDEX idx_instructors_email ON instructors(email);

CREATE INDEX idx_lessons_instructor_scheduled ON lessons(instructor_id, scheduled_at);

ALTER TABLE
  lessons
ALTER COLUMN
  student_id BIGINT NULL;

ALTER TABLE
  lessons
ADD
  CONSTRAINT FK_Lessons_Students FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE
SET
  NULL;

select * from lessons order by scheduled_at asc;

-- Объединение таблиц (joins)
SELECT 
    s.first_name,
    i.license_number,
    l.scheduled_at,
    'Lesson Info' as constant_value
FROM lessons l
INNER JOIN students s ON l.student_id = s.id
INNER JOIN instructors i ON l.instructor_id = i.id
WHERE l.status = 'scheduled' 
    AND l.scheduled_at > '2024-11-01'
ORDER BY l.scheduled_at ASC;

-- Объединение таблиц (joins)
SELECT 
    s.first_name,
    i.license_number,
    l.scheduled_at
FROM lessons l
INNER JOIN students s ON l.student_id = s.id
INNER JOIN instructors i ON l.instructor_id = i.id
WHERE s.first_name LIKE 'E%'
    OR l.scheduled_at BETWEEN '2024-11-01' AND '2024-11-15'
    OR l.status IN ('passed', 'pay_success')
ORDER BY l.scheduled_at DESC;

SELECT 
    s.first_name,
    i.license_number,
    l.scheduled_at,
    DATEDIFF(day, l.scheduled_at, GETDATE()) as days_after_lesson,
    CASE 
        WHEN l.status = 'passed' THEN 'Completed'
        WHEN l.status = 'scheduled' THEN 'Pending'
        ELSE 'Other'
    END as lesson_status
FROM lessons l
INNER JOIN students s ON l.student_id = s.id
INNER JOIN instructors i ON l.instructor_id = i.id
WHERE (l.status = 'scheduled' AND l.scheduled_at > GETDATE())
    OR s.first_name LIKE 'M%'
ORDER BY l.scheduled_at;


-- Манипуляция строками
SELECT 
    UPPER(first_name) as upper_name,
    LOWER(last_name) as lower_name,
    LEN(email) as email_length,
    LEFT(phone, 3) as country_code,
    SUBSTRING(email, 1, CHARINDEX('@', email) - 1) as username
FROM students;

-- Функции времени
SELECT 
    scheduled_at,
    DATEADD(day, 7, scheduled_at) as next_week,
    DATEPART(month, scheduled_at) as month_num,
    FORMAT(scheduled_at, 'yyyy-MM-dd') as formatted_date,
    DATEDIFF(day, created_at, scheduled_at) as days_difference
FROM lessons;

-- Преобразование типов
SELECT 
    CAST(scheduled_at AS DATE) as date_only,
    CONVERT(varchar, scheduled_at, 120) as formatted_datetime,
    CAST(created_at AS varchar) as string_date
FROM lessons;

select
    s.first_name,
    s.email,
    l.scheduled_at
from
    students s
    left join lessons l on s.id = l.student_id
where
    s.email like '%test%';
