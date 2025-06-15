-- Нам необходимо дать разрешение на изменение записей в базе данных
ALTER DATABASE pubs
SET
    READ_WRITE WITH no_wait;

GO
-- Удаляем триггер, если он уже существует
    IF object_id('trigger_before_insertion_publishers', 'TR') IS NOT NULL DROP TRIGGER trigger_before_insertion_publishers;

GO
-- Проверим данные до внесения изменения
SELECT
    *
FROM
    pubs.dbo.publishers;

SELECT
    *
FROM
    pubs.dbo.pub_info;

-- Реализация триггера
CREATE TRIGGER trigger_before_insertion_publishers ON pubs.dbo.publishers
AFTER
INSERT
    AS
BEGIN
IF EXISTS (
    SELECT
        1
    FROM
        inserted i
    WHERE
        NOT EXISTS (
            SELECT
                1
            FROM
                pubs.dbo.pub_info p
            WHERE
                p.pub_id = i.pub_id
        )
)
BEGIN
RAISERROR(
    N'Нельзя вставить запись в publishers: отсутствуют данные в pub_info.',
    16,
    1
);

ROLLBACK TRANSACTION;

END
END;

-- Попробуем вставить запись в таблицу publishers, когда pub_info ещё не содержит pub_id
INSERT INTO
    pubs.dbo.publishers
VALUES
    (
        '9905',
        N'Альпина паблишер',
        'Moscow',
        NULL,
        'RU'
    );

-- Здесь нам понадобится немного темной магии
-- Отключаем ограничение на foreign key на таблице pub_info, иначе будет ошибка.
-- Мы не можем добавить запись в publishers без записи в pub_info из-за триггера,
-- но и в pub_info мы не можем добавить запись, потому что есть ограничение FK(REFERENCE) на
-- существование записи в таблице publishers с таким pub_id.
ALTER TABLE
    pubs.dbo.pub_info NOCHECK CONSTRAINT FK__pub_info__pub_id__571DF1D5;

INSERT INTO
    pubs.dbo.pub_info
VALUES
    (
        '9997',
        'aabb\x001',
        'Sample text data fro alpinabook'
    );

-- Включаем ограничение обратно
ALTER TABLE
    pubs.dbo.pub_info CHECK CONSTRAINT FK__pub_info__pub_id__571DF1D5;

INSERT INTO
    pubs.dbo.publishers
VALUES
    (
        '9997',
        'Alpina Publisher',
        'Moscow',
        NULL,
        'Russia'
    );

-- Проверка на консистентность данных
SELECT
    *
FROM
    pubs.dbo.publishers p
    JOIN pubs.dbo.pub_info pi ON p.pub_id = pi.pub_id;

-- Возвращаем контекст на master
USE MASTER;

GO
