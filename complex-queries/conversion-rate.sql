--Calculate the conversion rate by browser for the web_events table, pivoting the data to show conversion status as columns:

SELECT browser,
    COUNT(CASE WHEN conversion_status = 'Completed' THEN 1 END) AS completed_count,
    COUNT(CASE WHEN conversion_status = 'Pending' THEN 1 END) AS pending_count,
    COUNT(CASE WHEN conversion_status = 'Failed' THEN 1 END) AS failed_count,
    COUNT(CASE WHEN conversion_status = 'Abandoned' THEN 1 END) AS abandoned_count,
    COUNT(CASE WHEN conversion_status = 'In Progress' THEN 1 END) AS in_progress_count
FROM web_events
GROUP BY browser;
