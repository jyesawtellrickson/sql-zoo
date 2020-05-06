-- Look up daily rates. Give the daily rate that should be paid for bookings with ids 5152, 5165, 5154 and 5295. Include booking id, room type, number of occupants and the amount.
SELECT
    b.booking_id,
    b.room_type_requested AS room_type,
    b.occupants,
    r.amount AS daily_rate
FROM
    booking AS b
    LEFT JOIN rate AS r
        ON r.room_type = b.room_type_requested
        AND r.occupancy = b.occupants
    -- Is room type always defined? 
    -- Is there always a match for occupants?
WHERE
    b.booking_id IN (5152, 5165, 5154, 5295)
ORDER BY
    b.booking_id ASC