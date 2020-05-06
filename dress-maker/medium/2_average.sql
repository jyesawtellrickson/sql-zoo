-- List the descriptions and the number of orders of the less popular garments, that is those for which less than the average number of orders per garment have been placed. Also print out the average number of orders per garment. When calculating the average, ignore any garments for which no orders have been made.
-- TODO: not running...
WITH style_orders AS (
    SELECT
        ol_style,
        COUNT(*) AS num_orders
    FROM
        order_line
    GROUP BY
        ol_style
), avg_orders AS (
    SELECT
        AVG(num_orders) AS avg_orders
    FROM
        style_orders
)

SELECT
    ol.ol_style AS style_no,
    g.description,
    ol.num_orders
FROM
    style_orders so
    JOIN garment g ON g.style_no = so.ol_style
WHERE
    ol.num_orders < (SELECT avg_orders FROM avg_orders)