WITH RECURSIVE hierarchy AS (
    SELECT
        staff_id,
        staff_name,
        1 level,
        ARRAY[staff_id] path
    FROM
        staff
    WHERE
        manager_id IS NULL
    UNION
    SELECT
        staff.staff_id,
        staff.staff_name,
        level +1 level,
        path || staff.staff_id path
    FROM
        staff,
        hierarchy
    WHERE
        path[level] = staff.manager_id
)
SELECT
    level
FROM
    hierarchy
ORDER BY
    level DESC
LIMIT 1;

