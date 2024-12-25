WITH skills AS (
    SELECT
        *,
        unnest(string_to_array(skills, ',')) skill
    FROM
        elves
)
SELECT
    count(*)
FROM
    skills
WHERE
    skill = 'SQL';

