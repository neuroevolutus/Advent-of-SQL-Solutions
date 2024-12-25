WITH possible_meeting_times AS (
    SELECT
        (concat(CURRENT_DATE, ' ', '00:00:00', ' ', 'UTC')::timestamptz + (generate_series(-24 * 60, 24 * 60, 30)::text || ' minutes')::interval) at time zone 'utc' meeting_start_utc,
        (concat(CURRENT_DATE, ' ', '01:00:00', ' ', 'UTC')::timestamptz + (generate_series(-24 * 60, 24 * 60, 30)::text || ' minutes')::interval) at time zone 'utc' meeting_end_utc
)
SELECT
    meeting_start_utc
FROM
    possible_meeting_times
WHERE
    meeting_start_utc >= ALL (
        SELECT
            (concat(CURRENT_DATE, ' ', business_start_time, ' ', timezone)::timestamptz) at time zone 'UTC'
        FROM
            workshops)
    AND meeting_end_utc <= ALL (
        SELECT
            (concat(CURRENT_DATE, ' ', business_end_time, ' ', timezone)::timestamptz) at time zone 'UTC'
        FROM
            workshops)
ORDER BY
    meeting_start_utc
LIMIT 1;

