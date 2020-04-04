/*
For each shift show the number of staff assigned.
Beware that some roles may be NULL and that the same person
might have been assigned to multiple roles (The roles are
'Manager', 'Operator', 'Engineer1', 'Engineer2').
*/

WITH shift_assignments AS (
    SELECT
        Shift_date,
        Shift_type,
        Manager AS Person
    FROM
        Shift

    UNION ALL

    SELECT
        Shift_date,
        Shift_type,
        Operator AS Person
    FROM
        Shift

    UNION ALL

    SELECT
        Shift_date,
        Shift_type,
        Engineer1 AS Person
    FROM
        Shift

    UNION ALL

    SELECT
        Shift_date,
        Shift_type,
        Engineer2 AS Person
    FROM
        Shift
)

SELECT
    DATE_TRUNC(DAY, Shift_date),
    Shift_type,
    COUNT(DISTINCT Person) AS cw
FROM 
    shift_assignments
GROUP BY
    1, 2
ORDER BY
    1,2 
;

/* Array approach */
-- NOT WORKING --
WITH shift_array AS (
    SELECT
        Shift_date,
        Shift_type,
        ARRAY[Manager, Operator, Engineer1, Engineer2] AS people
    FROM
        Shift
)

SELECT 
    Shift_date,
    Shift_type,
    COUNT(DISTINCT people_unnest)
FROM
    shift_array CROSS JOIN UNNEST(shift_array.people) AS people_unnest
GROUP BY
    1, 2