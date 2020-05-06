-- How many bookings, how many nights? For guests 1185 and 1270 show the number of bookings made and the total number of nights. Your output should include the guest id and the total number of bookings and the total number of nights.
SELECT
    guest_id,
    COUNT(*) AS num_bookings,
    SUM(nights) AS total_nights
FROM
    booking
WHERE
    guest_id IN (1185, 1270)
GROUP BY
    guest_id
ORDER BY
    total_nights DESC