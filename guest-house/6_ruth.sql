-- Ruth Cadbury. Show the total amount payable by guest Ruth Cadbury for her room bookings. You should JOIN to the rate table using room_type_requested and occupants.
SELECT
    SUM(r.amount * b.nights) AS amount_payable
FROM
    guest AS g
    INNER JOIN booking AS b ON b.guest_id = g.id
    INNER JOIN rate AS r
        ON r.room_type = b.room_type_requested
        AND r.occupancy = b.occupants
WHERE
    g.first_name = "Ruth"
    AND g.last_name = "Cadbury"