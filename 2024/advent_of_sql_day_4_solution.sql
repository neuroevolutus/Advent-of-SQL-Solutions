SELECT
    toy_id,
    (
        SELECT
            count(*)
        FROM (
            SELECT
                unnest(new_tags)
            EXCEPT
            SELECT
                unnest(previous_tags))) added_tags_count,
    (
        SELECT
            count(*)
        FROM (
            SELECT
                unnest(new_tags)
            INTERSECT
            SELECT
                unnest(previous_tags))) unchanged_tags_count,
    (
        SELECT
            count(*)
        FROM (
            SELECT
                unnest(previous_tags)
            EXCEPT
            SELECT
                unnest(new_tags))) removed_tags_count
FROM
    toy_production
ORDER BY
    added_tags_count DESC
LIMIT 1;

