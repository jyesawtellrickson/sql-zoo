-- Give the names of those dressmakers who have finished items made from silk for completed orders.

SELECT
    DISTINCT dm.d_name AS name
FROM
    dressmaker AS dm
    JOIN construction AS c ON c.maker = dm.d_no
    JOIN order_line AS ol ON ol.order_ref = c.order_ref AND ol.line_no = c.line_ref
    JOIN material AS m ON m.material_no = ol.ol_material
    JOIN dress_order AS do ON  ol.order_ref = do.order_no
WHERE
    m.fabric = "Silk"
    AND do.completed = "Y"
