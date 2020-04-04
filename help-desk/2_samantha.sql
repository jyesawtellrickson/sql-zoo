SELECT
    i.Call_date,
    c.First_name,
    c.Last_name
FROM
    Caller c
    INNER JOIN Issue i ON i.Caller_id = c.Caller_id
WHERE
    c.First_name = "Samantha"
    AND c.Last_name = "Hall"
    AND i.Call_date >= "2017-08-14"
    AND i.Call_date < "2017-08-15"