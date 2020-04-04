

SELECT
    cu.Company_name,
    COUNT(*) AS cc
FROM
    Issue i
    INNER JOIN Caller c ON c.Caller_id = i.Caller_id
    INNER JOIN Customer cu ON c.Company_ref = cu.Company_ref
GROUP BY
    1
HAVING
    cc > 18
ORDER BY
    cc DESC