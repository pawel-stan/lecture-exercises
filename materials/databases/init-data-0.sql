-- Początkowy stan danych – mniej więcej na tym skończyliśmy poprzednie zajęcia

-- Usuwamy całą tabelę wraz z danymi!
DROP TABLE IF EXISTS lecture;

CREATE TABLE lecture
(
    id            SERIAL PRIMARY KEY,
    room_number   INTEGER,
    teacher_name  VARCHAR(150),
    teacher_email VARCHAR(100),
    start_time    TIMESTAMP,
    end_time      TIMESTAMP,
    is_lab        BOOLEAN,
    name          VARCHAR(255)
);

INSERT INTO lecture ( room_number, teacher_name, teacher_email, start_time, end_time, is_lab, name )
VALUES ( 1, 'Kasia Nowak', 'knowak@db.pl', '2022-04-26 11:30', '2022-04-26 12:30', TRUE, 'SQL' ),
       ( 2, 'Jan Kowalski', 'jkowalski@db.pl', '2022-04-27 11:30', '2022-04-27 13:30', FALSE, 'Java' ),
       ( 3, 'Emilia Kot', 'ekot@db.pl', '2022-04-27 14:00', '2022-04-27 16:30', FALSE, 'CSS' ),
       ( 4, 'Jan Kowalski', 'jkowalski@db.pl', '2022-04-29 07:00', '2022-04-29 11:00', FALSE, 'HTML' ),
       ( 1, 'Kasia Nowak', 'knowak@db.pl', '2022-04-26 11:00', '2022-04-26 11:30', TRUE, 'Testy' );