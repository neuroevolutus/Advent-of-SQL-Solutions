WITH all_values AS (
    SELECT
        value
    FROM
        letters_a
    UNION ALL
    SELECT
        value
    FROM
        letters_b
),
all_letters AS (
    SELECT
        chr(value) letter
    FROM
        all_values
)
SELECT
    STRING_AGG(letter, '') message
FROM
    all_letters
WHERE (
    SELECT
        EXISTS (
            SELECT
                1
            FROM
                regexp_matches(letter, '[A-Za-z !"''\(\),\-\.:;\?]')));

