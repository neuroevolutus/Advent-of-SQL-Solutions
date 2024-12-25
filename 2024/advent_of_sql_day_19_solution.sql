WITH performance_avg AS (
    SELECT
        avg(year_end_performance_scores[array_length(year_end_performance_scores, 1)]) val
    FROM
        employees
)
SELECT
    round(sum(
            CASE WHEN year_end_performance_scores[array_length(year_end_performance_scores, 1)] > performance_avg.val THEN
                salary * 1.15
            ELSE
                salary
            END), 2)
FROM
    employees,
    performance_avg;

