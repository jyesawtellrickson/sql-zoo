/*
Consecutive calls occur when an operator deals with two callers within 10 minutes. Find the longest sequence of consecutive calls – give the name of the operator and the first and last call date in the sequence.

Questions:
 - Call_date only, no duration?

1. get the lag for each call date
2. Calculate the time difference and check
3. Get streak numbers
4. Groupby each streak to get max size
5. Join back with original table to get other data
*/

WITH Lagged_issue AS (
    SELECT
        *,
        COALESCE(
            TIMESTAMPDIFF(
                MINUTE,
                LAG(Call_date, 1) OVER (PARTITION BY Taken_by ORDER BY Call_date ASC),
                Call_date), 
            0) > 10 AS Non_consecutive_call  -- Boolean
    FROM
        Issue
), Streaked_issue AS (
    SELECT
        *,
        SUM(Non_consecutive_call) OVER (
            PARTITION BY Taken_by
            ORDER BY Call_date
            ) AS Streak_number
    FROM
        Lagged_issue
), Streak_stats AS (
    SELECT
        Taken_by,
        Streak_number,
        COUNT(*) AS Call_count,
        MIN(Call_date) AS First_call,
        MAX(Call_date) AS Last_call
    FROM 
        Streaked_issue AS si
    GROUP BY
        1, 2
)

SELECT
    CONCAT(s.First_name, " ", s.Last_name) AS operator,
    ss.Call_count,
    ss.First_call,
    ss.Last_call
FROM
    Streak_stats AS ss
    JOIN Staff AS s ON s.Staff_code = ss.Taken_by
ORDER BY
    2 DESC
LIMIT 1