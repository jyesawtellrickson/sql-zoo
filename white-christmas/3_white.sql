-- We declare a White Christmas if there was a day with an average temperature below zero between 21st and 25th of December.
-- For each age 1-12 show which years where a White Christmas.
SELECT
    yr-1811 AS age,
    CASE
        WHEN 0 > MIN(m12/10) THEN 'white'
        ELSE NULL
    END AS white_christmas
FROM
    hadcet
WHERE
    yr-1811 BETWEEN 1 AND 12
    AND dy BETWEEN 21 AND 25
    AND m12 != -999
GROUP BY
    age
ORDER BY
    age ASC