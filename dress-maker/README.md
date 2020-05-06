# Dress Maker

<https://sqlzoo.net/wiki/Dressmaker>

The "central" table in this database is order_line - every garment ordered takes one line in this table. Many of the fields in this table are references to other tables. The fields of this table have the following meaning:

order_ref

This is a link to the dress_order table. We can join the dress_order table to find information such as the the date of the order and the customer number for a given garment order.

line_no

The line number is used to distinguish different items on the same order - for example order number 5 has three lines - 1, 2 and 3.

ol_style

Indicates the article of clothing ordered. For example ol_style 1 indicates trousers - we can see this by joining to the garments table. Line 1 in the garment table is trousers.

ol_size

The size of the item ordered is given here - this is particularly important when it comes to working out how much material is required to build the item. We can see from the quantities table that trousers (style 1) in size 8 takes 2.7 meters - whereas trousers in size 12 needs 2.8 meters.

ol_material

Each order specifies the material to be used. We can join to the material table to find a description or cost per meter. Material 1 is Silk, Black, Plain costing £7 per meter.
