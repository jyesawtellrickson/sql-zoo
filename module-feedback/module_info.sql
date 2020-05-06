/**
 * Show the module code and module name for modules
 * studied by the student with number 50200100 in
 * session 2016/7 TR1
 */
SELECT
    I.MOD_CODE AS Code,
    COALESCE(I.MOD_NAME, "Unknown") AS Name
FROM
    CAM_SMO AS C
    LEFT JOIN INS_MOD AS I ON I.MOD_CODE = C.MOD_CODE
WHERE
    C.SPR_CODE = 50200100
    AND C.AYR_CODE = "2016/7"
    AND C.PSL_CODE = "TR1"