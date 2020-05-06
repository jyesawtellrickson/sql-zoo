-- Including Extras. Calculate the total bill for booking 5346 including extras.
WITH booking_extras AS (
    SELECT
        booking_id,
        SUM(amount) AS extras_amount
    FROM
        extra
    GROUP BY
        booking_id
)

SELECT
    r.amount * b.nights + COALESCE(e.extras_amount, 0) AS total_bill
FROM
    booking AS b
    INNER JOIN rate AS r
        ON r.room_type = b.room_type_requested
        AND r.occupancy = b.occupants
    LEFT JOIN booking_extras AS e USING (booking_id)
WHERE
    b.booking_id = 5346