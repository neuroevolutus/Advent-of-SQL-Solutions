WITH previous_day_productions AS (
    SELECT
        *,
        lag(toys_produced, 1) OVER (ORDER BY production_date ASC) previous_day_production
    FROM toy_production
),
production_changes AS (
    SELECT
        *,
        toys_produced - previous_day_production production_change
    FROM
        previous_day_productions
)
SELECT
    *,
    production_change / previous_day_production * 100.0 production_change_percentage
FROM
    production_changes
WHERE
    production_change IS NOT NULL
ORDER BY
    production_change_percentage DESC
LIMIT 1;

