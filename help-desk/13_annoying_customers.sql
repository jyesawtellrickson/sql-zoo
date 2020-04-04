/*
Annoying customers. Customers who call in the last five minutes of a shift are annoying. Find the most active customer who has never been annoying.

1. Identify annoying users
2. Order the customers by most active
3. Check which is in there

1. JOIN shift type, shift, staff, issue
2. Check if it is annoying call by doing hour / min calculation
3. Group by caller id
4. Filter not annoying customers

*/
WITH Annoying_users AS (
    SELECT DISTINCT
        Caller_id
    FROM
        Issue i
        JOIN Staff s ON i.Taken_by = s.Staff_code
        JOIN Shift sh ON sh.Operator = s.Staff_code
        JOIN Shift_type st ON st.Shift_type = sh.Shift_type
    WHERE
        -- Shifts always end on the hour, so we can use shortcut
        -- Calling the hour beforehand, within 5 minutes of end
        (HOUR(i.Call_date) = HOUR(st.End_time) - 1 AND MINUTE(i.Call_date) >= 55)
        -- Calling at the end of the shift
        OR (HOUR(i.Call_date) = HOUR(st.End_time))
)

SELECT
    cu.Company_name,
    COUNT(*) AS Call_count
FROM
    Issue i
    JOIN Caller c ON c.Caller_id = i.Caller_id
    JOIN Customer cu ON cu.Company_ref = c.Company_ref
WHERE
    i.Caller_id NOT IN (SELECT * FROM Annoying_users)
GROUP BY
    1
ORDER BY
    2 DESC
LIMIT
    1