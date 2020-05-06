-- List the post code, order number, order date and garment descriptions for all items associated with Ms Brown.
-- Filter cutsomer and join order info
SELECT
    jc.c_post_code AS postcode,
    ol.order_ref AS order_number,
    do.order_date,
    g.description
FROM
    jmcust AS jc
    JOIN dress_order AS do ON do.cust_no = jc.c_no
    JOIN order_line AS ol ON ol.order_ref = do.order_no
    JOIN garment AS g ON g.style_no = ol.ol_style
WHERE
    jc.c_name = "Ms Brown"