WITH sales_by_quarter AS (
    SELECT
        extract(year FROM sale_date) "year",
        extract(quarter FROM sale_date) quarter,
        sum(amount) total_sales
    FROM
        sales
    GROUP BY
        extract(year FROM sale_date),
        extract(quarter FROM sale_date)
),
growth_rates AS (
    SELECT
        *,
        (total_sales - lag(total_sales) OVER w) / lag(total_sales) OVER w growth_rate
            FROM sales_by_quarter
WINDOW w AS (ORDER BY year,
    quarter))
SELECT
    year,
    quarter
FROM
    growth_rates
WHERE
    growth_rate IS NOT NULL
ORDER BY
    growth_rate DESC
LIMIT 1;

