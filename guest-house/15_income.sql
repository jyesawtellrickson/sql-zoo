-- Gross income by week. Money is collected from guests when they leave. For each Thursday in November and December 2016, show the total amount of money collected from the previous Friday to that day, inclusive.
-- Get checkout dates from booking
-- Join with rate and extra to get total fee
-- Group by each checkout day
-- Group by each week
-- Filter just Nov/Dec
-- Will not show 0 dates, this could be accomplished using GENERATE_DATE_ARRAY in BQ or manually defining the values would work too.
WITH booking_extra AS (
    SELECT
        booking_id,
        SUM(amount) AS extra_amount
    FROM
        extra
    GROUP BY
        1
),

booking_revenues AS (
    SELECT
        b.*,
        b.booking_date + INTERVAL b.nights DAY AS checkout_date,
        COALESCE(e.extra_amount, 0) + COALESCE(r.amount*b.nights, 0) AS revenue
    FROM
        booking AS b
        LEFT JOIN rate AS r
            ON r.room_type = b.room_type_requested
            AND r.occupancy = b.occupants
        LEFT JOIN booking_extra AS e ON e.booking_id = b.booking_id
), 

-- Do a little tricky math and group by each thursday.
thursday_revenues AS (
    SELECT
        WEEK(checkout_date)
            + (CASE
                WHEN WEEKDAY(checkout_date) BETWEEN 4 AND 5 THEN 1
                ELSE 0
            END) AS new_week,
        MAX(checkout_date) + INTERVAL (6-MAX(MOD(WEEKDAY(checkout_date) + 3, 7))) DAY AS date,
        SUM(revenue) AS weekly_income
    FROM
        booking_revenues
    GROUP BY 
        1
),

-- Create an index of dates to join onto, can make it 90 days which will cover the two months.
date_index AS (
    SELECT
        "2016-11-01" + INTERVAL (rn-1) DAY AS date
    FROM
        (SELECT ROW_NUMBER() OVER () AS rn FROM booking LIMIT 90)q
)

SELECT 
    i.date AS Thursday,
    COALESCE(tr.weekly_income, 0) AS weekly_income
FROM
    date_index AS i
    LEFT JOIN thursday_revenues AS tr ON tr.date = i.date
WHERE
    WEEKDAY(i.date) = 3
    AND i.date BETWEEN "2016-11-01" AND "2017-01-06"