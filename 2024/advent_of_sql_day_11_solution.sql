WITH numbered_season_treeharvests AS (
    SELECT
        *,
        CASE WHEN season = 'Spring' THEN
            1
        WHEN season = 'Summer' THEN
            2
        WHEN season = 'Fall' THEN
            3
        ELSE
            4
        END season_number
    FROM
        treeharvests
),
three_season_moving_averages AS (
    SELECT
        field_name,
        harvest_year,
        season,
        round((trees_harvested + lag(trees_harvested, 1) OVER w + lag(trees_harvested, 2) OVER w) / 3.0, 2) three_season_moving_avg
    FROM numbered_season_treeharvests
WINDOW w AS (PARTITION BY field_name ORDER BY harvest_year,
    season_number))
SELECT
    three_season_moving_avg
FROM
    three_season_moving_averages
WHERE
    three_season_moving_avg IS NOT NULL
ORDER BY
    three_season_moving_avg DESC
LIMIT 1;

