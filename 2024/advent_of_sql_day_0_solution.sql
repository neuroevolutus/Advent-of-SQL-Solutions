WITH nice_scores AS (
    SELECT
        city,
        country,
        avg(naughty_nice_score) avg_naughty_nice_score
    FROM
        Children
        RIGHT JOIN ChristmasList USING (child_id)
    GROUP BY
        city, country
    HAVING
        count(*) > 4
),
nice_ranks AS (
    SELECT
        city,
        avg_naughty_nice_score,
        rank() OVER (PARTITION BY country ORDER BY avg_naughty_nice_score) nice_rank
    FROM nice_scores
)
SELECT
    city
FROM
    nice_ranks
WHERE
    nice_rank < 4
ORDER BY
    avg_naughty_nice_score DESC
LIMIT 5;

