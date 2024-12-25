WITH request_operands AS (
    SELECT
        request_id,
        unnest(string_to_array(regexp_replace(url, '(.*\?)(.*)', '\2'), '&')) request_operand
    FROM
        web_requests
),
request_objects AS (
    SELECT
        request_id,
        jsonb_object_agg(split_part(request_operand, '=', 1), split_part(request_operand, '=', 2)) request_object
    FROM
        request_operands
    GROUP BY
        request_id
)
SELECT
    url,
    count(query_params_obj.query_params) query_param_counts
FROM
    request_objects,
    web_requests,
    LATERAL (
        SELECT
            jsonb_object_keys(request_object) query_params
        FROM
            request_objects
        WHERE
            request_objects.request_id = web_requests.request_id) query_params_obj
WHERE
    jsonb_path_exists(request_object, '$.utm_source')
    AND request_objects.request_id = web_requests.request_id
GROUP BY
    url
ORDER BY
    query_param_counts DESC,
    url
LIMIT 1;

