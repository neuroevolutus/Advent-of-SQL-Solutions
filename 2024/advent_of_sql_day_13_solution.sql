WITH user_emails AS (
    SELECT
        name,
        unnest(email_addresses) email_address
    FROM
        contact_list
),
user_emails_and_domains AS (
    SELECT
        *,
        regexp_replace(email_address, '.*@(.*)', '\1') domain_name
    FROM
        user_emails
)
SELECT
    domain_name,
    count(*) total_users,
    array_agg(email_address) users
FROM
    user_emails_and_domains
GROUP BY
    domain_name
ORDER BY
    total_users DESC
LIMIT 1;

