-- Assuming that any garment could be made in any of the available materials, list the garments (description, fabric, colour and pattern) which are expensive to make, that is, those for which the labour costs are 80% or more of the total cost.
SELECT
    g.description,
    q.size_q AS size,
    m.fabric,
    m.colour,
    m.pattern,
    g.labour_cost,
    q.quantity * m.cost AS material_cost,
    CONCAT(ROUND(g.labour_cost / (g.labour_cost + q.quantity * m.cost) * 100),  '%') AS labour_cost_pct
FROM
    garment g
    JOIN quantities q ON g.style_no = q.style_q
    CROSS JOIN material m
WHERE
    g.labour_cost >= 0.8 * (g.labour_cost + q.quantity * m.cost)
ORDER BY
    labour_cost DESC