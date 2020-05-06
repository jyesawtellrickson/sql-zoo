/**
 * Find the name of the student with number 50200100
 */
SELECT
    CONCAT(SPR_FNM1, " ", SPR_SURN) AS Name
FROM 
    INS_SPR
WHERE
    SPR_CODE = 50200100