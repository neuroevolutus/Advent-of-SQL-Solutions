SELECT
    children.name
FROM
    children,
    gifts
WHERE
    children.child_id = gifts.child_id
    AND price > (
        SELECT
            avg(price)
        FROM
            gifts)
ORDER BY
    price ASC
LIMIT 1;

