/*
Show the manager and number of calls received for each hour of the day on 2017-08-12

1. Join: Issue, Staff, Shift, Staff
2. Filter call_date
3. Group by the manager, hour
4. Count issues

What about missing manager?
If we had missing manager, we could do outer join,
then coalesce nulls to an unknown.
*/

SELECT
    m.Staff_code AS Manager_id,
    CONCAT(m.First_name, " ", m.Last_name) AS Manager_name,
    EXTRACT(HOUR FROM i.Call_date) AS Hour,
    COUNT(*) AS Number_calls
FROM
    Issue i
    INNER JOIN Staff o ON o.Staff_code = i.Taken_by
    INNER JOIN Shift s ON s.Operator = o.Staff_code
    INNER JOIN Staff m ON m.Staff_code = s.Manager
WHERE
    Call_date >= "2017-08-12" AND Call_Date < "2017-08-13"
GROUP BY
    1, 2, 3
ORDER BY
    3, 1