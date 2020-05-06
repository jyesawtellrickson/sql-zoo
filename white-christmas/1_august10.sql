-- Show the average daily temperature for August 10th 1964
SELECT
    ROUND(m8/10, 1) AS average_daily_temperature
FROM
    hadcet
WHERE
    yr = 1964
    AND dy = 10