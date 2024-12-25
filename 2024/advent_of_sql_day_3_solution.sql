WITH menu_one_food_ids AS (
    SELECT
        unnest(xpath('//*/food_item_id/text()', menu_data))::text food_ids
    FROM
        christmas_menus
    WHERE (xpath('/*/@version', menu_data))[1]::text = '1.0'
    AND (xpath('//total_count/text()', menu_data))[1]::text::integer > 78
),
menu_two_food_ids AS (
    SELECT
        unnest(xpath('//*/food_item_id/text()', menu_data))::text food_ids
    FROM
        christmas_menus
    WHERE (xpath('/*/@version', menu_data))[1]::text = '2.0'
    AND (xpath('//total_guests/text()', menu_data))[1]::text::integer > 78
),
menu_three_food_ids AS (
    SELECT
        unnest(xpath('//*/food_item_id/text()', menu_data))::text food_ids
    FROM
        christmas_menus
    WHERE (xpath('/*/@version', menu_data))[1]::text = '3.0'
    AND (xpath('//total_present/text()', menu_data))[1]::text::integer > 78
),
all_food_ids AS (
    SELECT
        *
    FROM
        menu_one_food_ids
    UNION ALL
    SELECT
        *
    FROM
        menu_two_food_ids
    UNION ALL
    SELECT
        *
    FROM
        menu_three_food_ids
),
food_id_with_highest_count AS (
    SELECT
        food_ids,
        count(*) food_id_count
    FROM
        all_food_ids
    GROUP BY
        food_ids
    ORDER BY
        food_id_count DESC
    LIMIT 1
)
SELECT
    food_ids
FROM
    food_id_with_highest_count;

