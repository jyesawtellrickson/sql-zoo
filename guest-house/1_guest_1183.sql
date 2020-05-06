-- Guest 1183. Give the booking_date and the number of nights for guest 1183.
SELECT
    booking_date AS "Booking Date",
    nights AS "Nights"
FROM
    booking
WHERE
    guest_id = 1183
ORDER BY
    booking_date