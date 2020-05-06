-- Which garments have been made or are being made from 'red abstract' or 'blue abstract' coloured materials.
-- Filter material table, join garments and dress orders
SELECT
    DISTINCT g.description
FROM
    material AS m
    JOIN order_line AS ol ON ol.ol_material = m.material_no
    JOIN garment AS g ON ol.ol_style = g.style_no
WHERE
    m.colour = "Red Abstract" OR m.colour = "Blue Abstract" 
ORDER BY
    1