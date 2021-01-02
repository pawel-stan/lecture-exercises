# Bazy danych — ćwiczenie z wyzwalaczy

## Audit log

**Audit log** (lub _audit trail_), to chronologiczny zapis zmian jakiegoś procesu lub danych ([wikipedia](https://en.wikipedia.org/wiki/Audit_trail)).

Taki log często ma postać tabeli, której każdy wiersz odpowiada jednej konkretnej zmianie w innej tabeli.

## Zadanie

Przygotuj wyzwalacz, który będzie dodawać do tabeli `lecture_audit_log` nowy wiersz za każdym razem, gdy nastąpi jakaś zmiana w polach `name`, `start_time` lub `end_time` tabeli `lecture`. W `lecture_audit_log` powinny znajdować się informacje o czasie zmiany, a także o starej i nowej wartości.

## Tabela `lecture_audit_log`

Tabela `lecture_audit_log` powinna zawierać następujące kolumny:

- `id` — automatycznie generowany klucz główny;
- `date_created` — data dodania danego rekordu;
- `property` — nazwa pola, które się zmieniło — będzie to więc jedna z wartości `name`, `start_time` lub `end_time`;
- `old_value` — poprzednia (_stara_) wartość w danym polu `lecture` — może być `NULL`-em, jeśli zmianą jest dodanie nowego rekordu do `lecture`;
- `new_value` — aktualna (_nowa_) wartość w danym polu `lecture`.

### Uwagi

- sql udostępnia funkcje zwracające aktualny czas — [dokumentacja](https://www.sql.org/docs/current/functions-datetime.html#FUNCTIONS-DATETIME-CURRENT); na przykład `now()` lub `CURRENT_TIMESTAMP`;
- Jeśli chodzi o typy kolumn `old_value` i `new_value` — do kolumn typu tekstowego możemy zapisać także liczby oraz daty (sql sam wykona konwersję); `VARCHAR(X)` lub `TEXT` wydają się tu chyba dobrymi kandydatami.

## Workflow

1. Przygotuj dane wykorzystując skrypt [init-data.sql](./init-data.sql).
1. Utwórz tabelę `lecture_audit_log`, która będzie przechowywała informacje o zmianach w `lecture`.
1. Utwórz funkcję oraz wyzwalacz, które będą dodawać do `lecture_audit_log` nowy wiersz za każdym razem, gdy nastąpi jakaś zmiana w polach `name`, `start_time` lub `end_time` tabeli `lecture`.

Uwaga: Dodanie nowego rekordu do `lecture` do też zmiana — powinno skutkować dodaniem **trzech** wpisów do `lecture_audit_log`.

## Test

Wprowadźmy kilka zmian do tabelki `lecture`:

```sql
UPDATE lecture
SET name       = 'CSS3',
    start_time = '2021-01-03 12:00',
    end_time   = '2021-01-03 13:00'
WHERE id = 3;

INSERT INTO lecture ( teacher_id, room_id, start_time, end_time, name )
VALUES ( (SELECT id
          FROM teacher
          WHERE name = 'Ewa Mazur'),
         (SELECT id
          FROM room
          WHERE building = 'B'
            AND room_number = '13'),
         '2021-01-04 10:00',
         '2021-01-04 13:00',
         'Bootstrap' );

UPDATE lecture
SET end_time = '2021-01-04 13:45'
WHERE name = 'Bootstrap';
```

Jeśli wszystko pójdzie dobrze (a dane przygotujecie za pomocą [init-data.sql](./init-data.sql)), to po wykonaniu tych operacji w tabelce `lecture_audit_log` powinno znajdować się 7 wpisów:

```sql
SELECT *
FROM lecture_audit_log
ORDER BY id;

+--+--------------------------+----------+-------------------+-------------------+
|id|date_created              |property  |old_value          |new_value          |
+--+--------------------------+----------+-------------------+-------------------+
|1 |2021-01-02 14:18:48.738360|name      |CSS                |CSS3               |
|2 |2021-01-02 14:18:48.738360|start_time|2020-10-27 14:00:00|2021-01-03 12:00:00|
|3 |2021-01-02 14:18:48.738360|end_time  |2020-10-27 16:30:00|2021-01-03 13:00:00|
|4 |2021-01-02 14:18:48.738360|name      |NULL               |Bootstrap          |
|5 |2021-01-02 14:18:48.738360|start_time|NULL               |2021-01-04 10:00:00|
|6 |2021-01-02 14:18:48.738360|end_time  |NULL               |2021-01-04 13:00:00|
|7 |2021-01-02 14:18:48.738360|end_time  |2021-01-04 13:00:00|2021-01-04 13:45:00|
+--+--------------------------+----------+-------------------+-------------------+
```

Uwaga: Oczywiście dane w kolumnie `date_created` będą u Was inne.
