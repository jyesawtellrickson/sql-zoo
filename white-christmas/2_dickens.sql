-- Charles Dickens is said to be responsible for the tradition of expecting snow at Christmas Daily Telegraph. Show the temperature on Christmas day (25th December) for each year of his childhood. He was born in February 1812 - so he was 1 (more or less) in December 1812.
-- Show the twelve temperatures.
SELECT
    yr - 1811 AS age,
    CASE m12
        WHEN -999 THEN NULL
        ELSE ROUND(m12/10, 1)
        END AS christmas_temperature
FROM
    hadcet
WHERE
    dy = 25
    AND yr-1811 BETWEEN 1 AND 12