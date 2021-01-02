DROP TABLE IF EXISTS lecture CASCADE;

DROP TABLE IF EXISTS room;

DROP TABLE IF EXISTS teacher;

-- Nauczyciele

CREATE TABLE teacher
(
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    name  VARCHAR(150)        NOT NULL,
    title VARCHAR(15)
);

INSERT INTO teacher ( email, name, title )
VALUES ( 'knowak@db.pl', 'Kasia Nowak', 'mgr inż.' ),
       ( 'jkowalski@db.pl', 'Jan Kowalski', 'mgr' ),
       ( 'ekot@db.pl', 'Emilia Kot', 'prof. nadzw.' ),
       ( 'amarek@db.pl', 'Adam Marek', 'mgr inż.' ),
       ( 'amazur@db.pl', 'Anna Mazur', 'dr inż.' ),
       ( 'jkowal@db.pl', 'Jakub Kowal', 'dr' ),
       ( 'emazur@db.pl', 'Ewa Mazur', NULL );

-- Sale

CREATE TABLE room
(
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_number     VARCHAR(4)  NOT NULL,
    building        VARCHAR(20) NOT NULL,
    is_lab          BOOLEAN     NOT NULL,
    number_of_seats INTEGER     NOT NULL CHECK ( number_of_seats > 0 ),
    UNIQUE (room_number, building)
);

INSERT INTO room ( room_number, building, is_lab, number_of_seats )
VALUES ( '1', 'A', TRUE, 10 ),
       ( '2B', 'A', FALSE, 50 ),
       ( '3', 'B', FALSE, 30 ),
       ( '10', 'B', FALSE, 30 ),
       ( '6', 'B', FALSE, 20 ),
       ( '2', 'B', FALSE, 20 ),
       ( '3', 'A', TRUE, 40 ),
       ( '13', 'B', TRUE, 30 ),
       ( '2D', 'B', FALSE, 10 ),
       ( '12', 'B', FALSE, 40 ),
       ( '5', 'B', FALSE, 100 ),
       ( '4', 'A', FALSE, 30 );

-- Zajęcia

CREATE TABLE lecture
(
    id         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    teacher_id INTEGER REFERENCES teacher (id) NOT NULL,
    room_id    INTEGER REFERENCES room (id)    NOT NULL,
    start_time TIMESTAMP                       NOT NULL,
    end_time   TIMESTAMP                       NOT NULL,
    name       VARCHAR(255)                    NOT NULL,
    CHECK ( start_time < end_time )
);

INSERT INTO lecture ( teacher_id, room_id, start_time, end_time, name )
VALUES ( (SELECT id FROM teacher WHERE email = 'knowak@db.pl'), (SELECT id FROM room WHERE room_number = '1'),
         '2020-10-26 11:30', '2020-10-26 12:30', 'SQL' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '2B'),
         '2020-10-27 11:30', '2020-10-27 13:30', 'Java' ),
       ( (SELECT id FROM teacher WHERE email = 'ekot@db.pl'),
         (SELECT id FROM room WHERE room_number = '3' AND building = 'A'),
         '2020-10-27 14:00', '2020-10-27 16:30', 'CSS' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '4'),
         '2020-10-29 07:00', '2020-10-29 11:00', 'HTML' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '2B'),
         '2020-10-27 11:30', '2020-10-27 13:30', 'Java' ),
       ( (SELECT id FROM teacher WHERE email = 'ekot@db.pl'),
         (SELECT id FROM room WHERE room_number = '3' AND building = 'B'),
         '2020-10-27 14:00', '2020-10-27 16:30', 'CSS' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '5'),
         '2020-10-29 07:00', '2020-12-19 11:00', 'HTML' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '2B'),
         '2020-10-27 11:30', '2020-12-24 13:30', 'Java' ),
       ( (SELECT id FROM teacher WHERE email = 'ekot@db.pl'), (SELECT id FROM room WHERE room_number = '13'),
         '2020-10-27 14:00', '2020-12-02 16:30', 'CSS' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '4'),
         '2020-10-29 07:00', '2020-12-02 11:00', 'HTML' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '2D'),
         '2020-10-27 11:30', '2020-12-01 13:30', 'Java' ),
       ( (SELECT id FROM teacher WHERE email = 'ekot@db.pl'), (SELECT id FROM room WHERE room_number = '5'),
         '2020-10-27 14:00', '2020-11-06 16:30', 'SQL' ),
       ( (SELECT id FROM teacher WHERE email = 'jkowalski@db.pl'), (SELECT id FROM room WHERE room_number = '6'),
         '2020-10-29 07:00', '2020-11-05 11:00', 'HTML' ),
       ( (SELECT id FROM teacher WHERE email = 'knowak@db.pl'), (SELECT id FROM room WHERE room_number = '10'),
         '2020-10-26 11:00', '2020-11-05 11:30', 'SQL' );