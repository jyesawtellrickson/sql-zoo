-- Show the manager for each shift. Your output should include the shift date and type;
-- also the first and last name of the manager.

SELECT DISTINCT
    sh.Shift_date,
    sh.Shift_type,
    s.First_name,
    s.Last_name
FROM
    Shift sh
    LEFT JOIN Staff s ON sh.Manager = s.Staff_code
ORDER BY
    sh.Shift_date