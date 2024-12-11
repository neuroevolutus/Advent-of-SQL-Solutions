WITH consumption AS (
    SELECT
        date,
        sum(quantity) FILTER (WHERE drink_name = 'Hot Cocoa') HotCocoa,
        sum(quantity) FILTER (WHERE drink_name = 'Peppermint Schnapps') PeppermintSchnapps,
        sum(quantity) FILTER (WHERE drink_name = 'Eggnog') Eggnog
    FROM
        drinks
    GROUP BY
        date
)
SELECT
    date
FROM
    consumption
WHERE
    HotCocoa = 38
    AND PeppermintSchnapps = 298
    AND Eggnog = 198;

