--------------------------------------------------------------
-- Stan danych po wykonaniu ćwiczenia nr 1 -------------------
--------------------------------------------------------------

DROP TABLE IF EXISTS lecture;

DROP TABLE IF EXISTS room;

DROP TABLE IF EXISTS teacher;

-- Nauczyciele

CREATE TABLE teacher
(
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR(100),
    name  VARCHAR(150),
    title VARCHAR(15)
);

INSERT INTO teacher ( email, name, title )
VALUES ( 'knowak@db.pl', 'Kasia Nowak', 'mgr inż.' ),
       ( 'jkowalski@db.pl', 'Jan Kowalski', 'mgr' ),
       ( 'ekot@db.pl', 'Emilia Kot', 'prof. nadzw.' ),
       ( 'emazur@db.pl', 'Ewa Mazur', NULL );

-- Sale

CREATE TABLE room
(
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_number     VARCHAR(4),
    building        VARCHAR(20),
    is_lab          BOOLEAN,
    number_of_seats INTEGER
);

INSERT INTO room ( room_number, building, is_lab, number_of_seats )
VALUES ( '1', 'A', TRUE, 10 ),
       ( '2B', 'A', FALSE, 50 ),
       ( '3', 'B', FALSE, 30 ),
       ( '4', 'A', FALSE, 30 );

-- Zajęcia

CREATE TABLE lecture
(
    id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    teacher_id INTEGER REFERENCES teacher (id),
    room_id    INTEGER REFERENCES room (id),
    start_time TIMESTAMP,
    end_time   TIMESTAMP,
    name       VARCHAR(255)
);

INSERT INTO lecture ( teacher_id, room_id, start_time, end_time, name )
VALUES ( (SELECT id FROM teacher WHERE email = 'knowak@db.pl'), (SELECT id FROM room WHERE room_number = '1'),
         '2022-04-26 11:30', '2022-04-26 12:30', 'SQL' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '2B'),
         '2022-04-27 11:30', '2022-04-27 13:30', 'Java' ),
       ( (SELECT id FROM teacher WHERE email = 'ekot@db.pl'), (SELECT id FROM room WHERE room_number = '3'),
         '2022-04-27 14:00', '2022-04-27 16:30', 'CSS' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '4'),
         '2022-04-29 07:00', '2022-04-29 11:00', 'HTML' ),
       ( (SELECT id FROM teacher WHERE email = 'knowak@db.pl'), (SELECT id FROM room WHERE room_number = '1'),
         '2022-04-26 11:00', '2022-04-26 11:30', 'Testy' );
