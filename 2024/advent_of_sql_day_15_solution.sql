SELECT
    timestamp,
    place_name area
FROM
    sleigh_locations,
    areas
WHERE
    ST_within (coordinate::geometry, polygon::geometry)
ORDER BY
    timestamp DESC
LIMIT 1;

