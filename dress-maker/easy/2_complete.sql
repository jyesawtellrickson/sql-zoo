-- List the customer name, postal information, order date and order number of all orders that have been completed.
-- Filter completed and join other info
SELECT
    jc.c_name AS name,
    jc.c_post_code AS postcode,
    jc.c_house_no AS house_number,
    do.order_date,
    ol.order_ref AS order_number
FROM
    jmcust AS jc
    JOIN dress_order AS do ON do.cust_no = jc.c_no
    JOIN order_line AS ol ON ol.order_ref = do.order_no
WHERE
    do.completed = "Y"