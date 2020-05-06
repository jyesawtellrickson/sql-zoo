-- Edinburgh Residents. For every guest who has the word “Edinburgh” in their address show the total number of nights booked. Be sure to include 0 for those guests who have never had a booking. Show last name, first name, address and number of nights. Order by last name then first name.
SELECT
    g.last_name,
    g.first_name,
    g.address,
    COALESCE(SUM(nights), 0) AS num_nights
FROM
    guest AS g
    LEFT JOIN booking AS b ON b.guest_id = g.id
WHERE
    g.address LIKE "%Edinburgh%"
    -- consider different capitalisations, can take LOWER first
GROUP BY
    1, 2, 3
ORDER BY
    1, 2
