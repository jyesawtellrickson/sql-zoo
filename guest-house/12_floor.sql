-- Check out per floor. The first digit of the room number indicates the floor – e.g. room 201 is on the 2nd floor. For each day of the week beginning 2016-11-14 show how many rooms are being vacated that day by floor number. Show all days in the correct order.

-- Can check how many floors first with a query: 3.
-- Assume no rooms on ground floor, or check
-- Generate 1 column for each floor, date as index

WITH first AS (
    SELECT
        booking_date + INTERVAL nights DAY AS vacation_day,
        COUNT(*) AS num_rooms
    FROM
        booking
    WHERE
        FLOOR(room_no / 100) = 1
    GROUP BY
        1
), second AS (
    SELECT
        booking_date + INTERVAL nights DAY AS vacation_day,
        COUNT(*) AS num_rooms
    FROM
        booking
    WHERE
        FLOOR(room_no / 100) = 2
    GROUP BY
        1
), third AS (
    SELECT
        booking_date + INTERVAL nights DAY AS vacation_day,
        COUNT(*) AS num_rooms
    FROM
        booking
    WHERE
        FLOOR(room_no / 100) = 3
    GROUP BY
        1
)

SELECT
    COALESCE(
        f.vacation_day,
        s.vacation_day,
        t.vacation_day
    ) AS vacation_day,
    COALESCE(f.room_no, 0) AS first_floor,
    COALESCE(s.room_no, 0) AS second_floor,
    COALESCE(t.room_no, 0) AS third_floor
FROM
    first AS f
    FULL OUTER JOIN second AS s ON f.vacation_day = s.vacation_day
    FULL OUTER JOIN third AS t ON f.vacation_day = t.vacation_day
WHERE
    (
        f.vacation_day > "2016-11-14"
        OR s.vacation_day > "2016-11-14"
        OR t.vacation_day > "2016-11-14"
    )
ORDER BY
    1
;


-- Another method with CASE
-- could achieve similar results with LIKE "1%" etc.
SELECT
    booking_date + INTERVAL nights DAY AS checkout_date,
    SUM(
        CASE
            WHEN FLOOR(room_no / 100) = 1 THEN 1
            ELSE 0
        END
        ) AS first_floor,
    SUM(
        CASE
            WHEN FLOOR(room_no / 100) = 2 THEN 1
            ELSE 0
        END
        ) AS second_floor,
    SUM(
        CASE
            WHEN FLOOR(room_no / 100) = 3 THEN 1
            ELSE 0
        END
        ) AS third_floor
FROM
    booking
WHERE
    booking_date + INTERVAL nights DAY >= "2016-11-14"
GROUP BY
    1
ORDER BY
    1 ASC
;