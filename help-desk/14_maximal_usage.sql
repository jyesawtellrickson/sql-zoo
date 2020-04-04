/*
Maximal usage. If every caller registered with a customer makes a call in one day then that customer has "maximal usage" of the service. List the maximal customers for 2017-08-13.

1. Get list of customer / company who make a call
2. Check if they made a call on that day
3. Aggregate by the company and count number of people who didn't make a call
4. Filter who made at least one call

Note: Seems the solution provided on site is incorrect,
the number of issues is greater than the number of callers
when e.g. one person calls multiple times in the day.
*/

WITH Full_callers AS (
    SELECT DISTINCT
        Company_ref,
        Caller_id
    FROM
        Caller
),

Caller_counts AS (
    SELECT
        Caller_id,
        COUNT(*) AS Call_count
    FROM
        Issue
    WHERE
        Call_date >= "2017-08-13" AND Call_date < "2017-08-14"
    GROUP BY
        1
)

SELECT
    c.Company_name AS company_name,
    COUNT(*) AS caller_count,
    SUM(Call_count) AS issue_count
FROM
    Full_callers fc
    LEFT JOIN Caller_counts cc ON cc.Caller_id = fc.Caller_id
    LEFT JOIN Customer c ON c.Company_ref = fc.Company_ref
GROUP BY
    1
HAVING
    SUM(CASE WHEN Call_count IS NULL THEN 1 ELSE 0 END) = 0
