-- How many guests? Show the number of guests in the hotel on the night of 2016-11-21. Include all occupants who checked in that day but not those who checked out.
SELECT
    SUM(occupants) AS num_guests
FROM
    booking
WHERE
    -- Check-out date is after the condition
    booking_date + INTERVAL nights DAY > "2016-11-21"
    -- BQ: DATE_DIFF("2016-11-21", booking_date, DAY) < nights
    -- Check-in before the condition
    AND booking_date <= "2016-11-21"
