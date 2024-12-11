WITH average_speeds_by_exercise_type AS (
    SELECT
        reindeer_name,
        round(avg(speed_record), 2) exercise_speed_record
    FROM
        reindeers
        INNER JOIN training_sessions USING (reindeer_id)
    WHERE
        reindeer_name != 'Rudolph'
    GROUP BY
        reindeer_name, exercise_name
),
highest_average_speeds AS (
    SELECT
        reindeer_name,
        max(exercise_speed_record) top_speed
    FROM
        average_speeds_by_exercise_type
    GROUP BY
        reindeer_name
)
SELECT
    *
FROM
    highest_average_speeds
ORDER BY
    top_speed DESC
LIMIT 3;

