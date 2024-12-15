SELECT
    receipts.record_date,
    receipts.receipt_details
FROM (
    SELECT
        record_date,
        jsonb_array_elements(cleaning_receipts) receipt_details
    FROM
        SantaRecords) receipts
WHERE
    receipt_details ->> 'garment' = 'suit'
    AND receipt_details ->> 'color' = 'green'
ORDER BY
    record_date DESC
LIMIT 1;

