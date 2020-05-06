-- How many garments has each dressmaker constructed? You should give the number of garments and the name and postal information of each dressmaker.
SELECT
    dm.d_name AS name,
    dm.d_house_no AS house_number,
    dm.d_post_code AS postcode,
    COUNT(*) AS number_garments
FROM
    dressmaker AS dm
    JOIN construction AS c ON c.maker = dm.d_no
    JOIN order_line AS ol ON ol.order_ref = c.order_ref AND ol.line_no = c.line_ref
GROUP BY
    1,2,3
ORDER BY
    number_garments DESC,
    name DESC