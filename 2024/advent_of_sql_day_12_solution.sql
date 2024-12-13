WITH total_gift_requests AS (
    SELECT
        gift_name,
        count(*) total_requests
    FROM
        gifts
        INNER JOIN gift_requests USING (gift_id)
    GROUP BY
        gift_id
),
gift_rankings AS (
    SELECT
        gift_name,
        round(PERCENT_RANK() OVER (ORDER BY total_requests)::numeric(4, 3), 2) overall_rank,
    dense_rank() OVER (ORDER BY total_requests DESC) dense_rank
FROM total_gift_requests
)
SELECT
    *
FROM
    gift_rankings
WHERE
    dense_rank = 2
ORDER BY
    gift_name;

