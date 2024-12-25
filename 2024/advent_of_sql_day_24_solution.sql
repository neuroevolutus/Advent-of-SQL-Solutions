WITH plays_and_songs AS (
    SELECT
        *
    FROM
        user_plays
        NATURAL JOIN songs
)
SELECT
    song_title,
    count(*) total_plays,
    count(*) FILTER (WHERE duration < song_duration) total_skips
FROM
    plays_and_songs
GROUP BY
    song_title
ORDER BY
    total_plays DESC,
    total_skips
LIMIT 1;

