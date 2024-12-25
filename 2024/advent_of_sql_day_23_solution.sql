WITH min_id AS (
    SELECT
        min(id) value
    FROM
        sequence_table
),
max_id AS (
    SELECT
        max(id) value
    FROM
        sequence_table
),
all_ids AS (
    SELECT
        generate_series(min_id.value, max_id.value) id
    FROM
        min_id,
        max_id
),
missing_ids AS (
    SELECT
        all_ids.id missing_id
    FROM
        all_ids
        LEFT JOIN sequence_table USING (id)
    WHERE
        sequence_table.id IS NULL
),
GROUPS AS (
    SELECT
        missing_id,
        missing_id - row_number() OVER (ORDER BY missing_id) AS
    GROUP
FROM
    missing_ids
)
SELECT
    min(missing_id) gap_start,
    max(missing_id) gap_end,
    array_agg(missing_id) missing_numbers
FROM
    GROUPS
GROUP BY
    groups.group;

