-- Calls are not normally assigned to a manager but it does happen. How many calls have been assigned to staff who are at Manager Level?

SELECT
    COUNT(*) AS mlcc
FROM 
    Issue i
    INNER JOIN Staff s ON s.Staff_code = i.Assigned_to
    INNER JOIN Level l ON l.Level_code = s.Level_code
WHERE
    l.Manager IS NOT NULL