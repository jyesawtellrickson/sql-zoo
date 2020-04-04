-- Find the callers who have never made a call. Show first name and last name

SELECT
    First_name,
    Last_name
FROM
    Caller c
    LEFT JOIN Issue i ON i.Caller_id = c.Caller_id
WHERE
    i.Call_ref IS NULL
;

-- Using NOT IN
SELECT
    First_name,
    Last_name
FROM
    Caller
WHERE
    Caller_id NOT IN (SELECT DISTINCT Caller_id FROM Issue)