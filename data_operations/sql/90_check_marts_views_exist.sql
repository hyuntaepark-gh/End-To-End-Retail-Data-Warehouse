-- Check required marts views exist
SELECT table_name
FROM information_schema.views
WHERE table_schema = 'marts'
ORDER BY table_name;
