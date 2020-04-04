-- Note: table diagram on site is missing Contact_id

SELECT
    cu.Company_name,
    con.First_name,
    con.Last_name,
    COUNT(*) AS nc
FROM
    Issue i
    INNER JOIN Caller c ON c.Caller_id = i.Caller_id
    LEFT JOIN Customer cu ON cu.Company_ref = c.Company_ref
    JOIN Caller con ON con.Caller_id = cu.Contact_id
GROUP BY
    1, 2
HAVING
    nc < 5
ORDER BY 
    nc DESC, cu.Company_name