WITH RECURSIVE hierarchy AS (
    SELECT
        staff_id,
        staff_name,
        1 level,
        ARRAY[staff_id] path,
        manager_id
    FROM
        staff
    WHERE
        manager_id IS NULL
    UNION
    SELECT
        staff.staff_id,
        staff.staff_name,
        level +1 level,
        path || staff.staff_id path,
        staff.manager_id
    FROM
        staff,
        hierarchy
    WHERE
        path[level] = staff.manager_id
),
peers_count_same_manager AS (
    SELECT
        manager_id,
        count(*) peers_same_manager
    FROM
        hierarchy
    GROUP BY
        manager_id
),
peers_count_same_level AS (
    SELECT
        level,
        count(*) total_peers_same_level
    FROM
        hierarchy
    GROUP BY
        level
),
all_info AS (
    SELECT
        *
    FROM
        hierarchy
        INNER JOIN peers_count_same_manager USING (manager_id)
        INNER JOIN peers_count_same_level USING (level))
SELECT
    staff_id
FROM
    all_info
ORDER BY
    total_peers_same_level DESC,
    level,
    staff_id
LIMIT 1;

