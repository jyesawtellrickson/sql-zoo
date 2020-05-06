-- Free rooms? List the rooms that are free on the day 25th Nov 2016.
WITH occupants AS (
    SELECT
        room_no,
        TRUE AS occupied
    FROM
        booking
    WHERE
        booking_date <= "2016-11-25"
        AND booking_date + INTERVAL nights DAY > "2016-11-25"
)

SELECT
    r.id AS room_id
FROM
    room AS r
    LEFT JOIN occupants AS o ON r.id = o.room_no
WHERE
    o.occupied IS NULL
ORDER BY
    1 ASC