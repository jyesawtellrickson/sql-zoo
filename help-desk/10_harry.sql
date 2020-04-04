-- Caller 'Harry' claims that the operator who took his most recent call was abusive and insulting. Find out who took the call (full name) and when.
/*
What if there are multiple people with first name Harry

1. Join: Caller, Issue, Staff
2. Filter out caller name is Harry
3. Order By time of the call
4. First Row

*/

SELECT
    s.First_name,
    s.Last_name,
    i.Call_date
FROM
    Caller c
    INNER JOIN Issue i ON i.Caller_id = c.Caller_id
    INNER JOIN Staff s ON s.Staff_code = i.Taken_by
WHERE
    c.First_name = "Harry"
ORDER BY
    Call_date DESC
LIMIT 1