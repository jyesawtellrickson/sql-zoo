-- How busy are we? For each day of the week beginning 2016-11-25 show the number of bookings starting that day. Be sure to show all the days of the week in the correct order.

-- BigQuery SQL solution, where there could be gaps
WITH dates AS (
    SELECT
        *
    FROM
        UNNEST(GENERATE_DATE_ARRAY(
            "2016-11-25",
            (SELECT MAX(booking_date) FROM booking),
            INTERVAL 1 DAY
        )) AS date
)
SELECT
    d.date,
    COUNT(*) AS num_bookings
FROM
    dates AS d
    LEFT JOIN booking AS b
GROUP BY
    1
ORDER BY
    1 ASC;

-- Basic Solution
SELECT
    booking_date,
    COUNT(*)
FROM
    booking
WHERE
    booking_date >= "2016-11-25"
GROUP BY
    1
ORDER BY
    1