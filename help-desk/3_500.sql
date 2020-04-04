-- There are 500 calls in the system (roughly). Write a query that shows the number that have each status.

SELECT
    status,
    COUNT(status) AS Volume
FROM
    Issue
GROUP BY
    1
ORDER BY
    Volume DESC