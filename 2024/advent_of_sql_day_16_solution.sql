WITH durations AS (
    SELECT
        place_name,
        extract(epoch FROM timestamp - lag(timestamp) OVER (ORDER BY timestamp)) / 3600 duration
    FROM sleigh_locations,
    areas
    WHERE ST_within (coordinate::geometry, polygon::geometry))
SELECT
    place_name
FROM
    durations
WHERE
    duration IS NOT NULL
ORDER BY
    duration DESC
LIMIT 1;

