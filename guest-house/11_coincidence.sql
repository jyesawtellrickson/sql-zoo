-- Coincidence. Have two guests with the same surname ever stayed in the hotel on the evening? Show the last name and both first names. Do not include duplicates.
WITH guest_booking AS (
    SELECT
        *,
        booking_date + INTERVAL nights DAY AS checkout_date
    FROM
        guest AS g
        INNER JOIN booking AS b ON b.guest_id = g.id
), ans AS (
    SELECT DISTINCT
        gb1.last_name,
        gb1.first_name AS guest_1,
        gb2.first_name AS guest_2
    FROM
        guest_booking AS gb1
        CROSS JOIN guest_booking AS gb2
    WHERE
        -- Don't match with the same person
        gb1.guest_id != gb2.guest_id
        -- Last name is the same
        AND gb1.last_name = gb2.last_name
        -- Overlap in timings.
        AND gb1.booking_date < gb2.checkout_date
        AND gb2.booking_date < gb1.checkout_date
    ORDER BY
        1, 2, 3
),
-- Each row is duplicated, so drop every second row
rn_ans AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY last_name) AS rn
    FROM
        ans
)

SELECT
    last_name,
    guest_1,
    guest_2
FROM
    rn_ans
WHERE
    MOD(rn, 2) = 0
ORDER BY
    1, 2, 3