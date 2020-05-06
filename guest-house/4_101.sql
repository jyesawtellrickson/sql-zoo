-- Who’s in 101? Find who is staying in room 101 on 2016-12-03, include first name, last name and address.
SELECT
    g.first_name,
    g.last_name,
    g.address
FROM
    booking AS b
    INNER JOIN guest AS g ON g.id = b.guest_id
WHERE
    b.room_no = 101
    AND b.booking_date = "2016-12-03"