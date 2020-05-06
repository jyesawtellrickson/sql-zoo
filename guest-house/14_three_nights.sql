-- Single room for three nights required. A customer wants a single room for three consecutive nights. Find the first available date in December 2016.
-- Assume the room is booked at least once before Dec 1st
-- Coalesce with big number to cover when it's not booked again
WITH gaps AS (
    SELECT
        room_no,
        booking_date + INTERVAL nights DAY AS checkout_date,
        COALESCE(DATEDIFF(
            LEAD(booking_date, 1) OVER (
                PARTITION BY room_no
                ORDER BY booking_date),
            booking_date + INTERVAL nights DAY
            ), 100) AS days_available
    FROM
        booking
),

booked_rooms AS (
    SELECT
        room_no,
        checkout_date
    FROM
        gaps
    WHERE
        days_available >= 3
        AND checkout_date >= "2016-12-01"
),

-- Handle cases when the room was never booked
never_booked AS (
    SELECT
        id AS room_no,
        "2016-12-01" AS checkout_date
    FROM
        room
    WHERE
        id NOT IN (SELECT DISTINCT room_no FROM booking)
),

-- Handle cases where the room was first booked after Dec 3
first_booked_after_pre AS (
    SELECT
        room_no,
        MIN(booking_date) AS min_booking_date
    FROM
        booking
    GROUP BY
        1
), first_booked_after AS (
    SELECT
        room_no,
        "2016-12-01" AS checkout_date
    FROM
        first_booked_after_pre
    WHERE
        min_booking_date > "2016-12-03"
)

SELECT
    a.room_no,
    a.checkout_date
FROM
    (
        SELECT * FROM never_booked
        UNION ALL
        SELECT * FROM booked_rooms
    ) AS a
    INNER JOIN room AS r ON r.id = a.room_no
WHERE
    r.max_occupancy = 1
ORDER BY
    checkout_date ASC
LIMIT
    1