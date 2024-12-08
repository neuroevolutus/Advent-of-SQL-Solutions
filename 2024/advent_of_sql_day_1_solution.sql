SELECT
    children_wishes.name,
    children_wishes.primary_wish,
    children_wishes.backup_wish,
    children_wishes.favorite_color,
    children_wishes.color_count,
    toys.gift_complexity,
    toys.workshop_assignment
FROM (
    SELECT
        name,
        wishes ->> 'first_choice' primary_wish,
        wishes ->> 'second_choice' backup_wish,
        wishes -> 'colors' ->> 0 favorite_color,
        json_array_length(wishes -> 'colors') color_count
    FROM
        children,
        wish_lists
    WHERE
        children.child_id = wish_lists.child_id) children_wishes,
    (
        SELECT
            toy_name,
            CASE WHEN difficulty_to_make = 1 THEN
                'Simple Gift'
            WHEN difficulty_to_make = 2 THEN
                'Moderate Gift'
            ELSE
                'Complex Gift'
            END gift_complexity,
            CASE WHEN category = 'outdoor' THEN
                'Outside Workshop'
            WHEN category = 'educational' THEN
                'Learning Workshop'
            ELSE
                'General Workshop'
            END workshop_assignment
        FROM
            toy_catalogue) toys
WHERE
    children_wishes.primary_wish = toys.toy_name
ORDER BY
    name ASC
LIMIT 5;

