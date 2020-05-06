-- A person's White Christmas Count (wcc) is the number of White Christmases they were exposed to as a child (between 3 and 12 inclusive assuming they were born at the beginning of the year and were about 1 year old on their first Christmas).
-- Charles Dickens's wcc was 8.
-- List all the years and the wcc for children born in each year of the data set. Only show years where the wcc was at least 7.
-- Determine if a given year was white, then cross-join and SUM white christmases in range
WITH white_years AS (
    SELECT
        yr,
        CASE WHEN MIN(m12) < 0 THEN 1 ELSE 0 END AS white
    FROM
        hadcet
    WHERE
        dy BETWEEN 21 and 25
        AND m12 != -999
    GROUP BY
        yr
)

SELECT
    w1.yr AS birth_year,
    SUM(w2.white) AS wcc
FROM
    white_years w1
    CROSS JOIN white_years w2
WHERE
    w2.yr - w1.yr BETWEEN 2 AND 11
GROUP BY
    w1.yr
HAVING
    wcc >= 7