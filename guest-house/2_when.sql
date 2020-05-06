-- When do they get here? List the arrival time and the first and last names for all guests due to arrive on 2016-11-05, order the output by time of arrival.
SELECT
    b.arrival_time,
    g.first_name,
    g.last_name
FROM
    booking AS b
    LEFT JOIN guest AS g ON g.id = b.guest_id
WHERE
    b.booking_date = "2016-11-05"
ORDER BY
    b.arrival_time ASC