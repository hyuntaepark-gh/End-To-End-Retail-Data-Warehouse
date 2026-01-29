CREATE TABLE IF NOT EXISTS dw.dim_date (
  date_key        INTEGER PRIMARY KEY,          -- yyyymmdd
  date            DATE NOT NULL UNIQUE,
  year            SMALLINT NOT NULL,
  quarter         SMALLINT NOT NULL CHECK (quarter BETWEEN 1 AND 4),
  month           SMALLINT NOT NULL CHECK (month BETWEEN 1 AND 12),
  day             SMALLINT NOT NULL CHECK (day BETWEEN 1 AND 31),
  day_of_week     SMALLINT NOT NULL CHECK (day_of_week BETWEEN 1 AND 7), -- ISO: 1=Mon..7=Sun
  week_of_year    SMALLINT NOT NULL CHECK (week_of_year BETWEEN 1 AND 53),
  is_weekend      BOOLEAN NOT NULL,
  is_month_start  BOOLEAN NOT NULL,
  is_month_end    BOOLEAN NOT NULL
);
INSERT INTO dw.dim_date (
  date_key,
  date,
  year,
  quarter,
  month,
  day,
  day_of_week,
  week_of_year,
  is_weekend,
  is_month_start,
  is_month_end
)
SELECT
  (EXTRACT(YEAR FROM d)::int * 10000
   + EXTRACT(MONTH FROM d)::int * 100
   + EXTRACT(DAY FROM d)::int) AS date_key,
  d::date AS date,
  EXTRACT(YEAR FROM d)::smallint AS year,
  EXTRACT(QUARTER FROM d)::smallint AS quarter,
  EXTRACT(MONTH FROM d)::smallint AS month,
  EXTRACT(DAY FROM d)::smallint AS day,
  EXTRACT(ISODOW FROM d)::smallint AS day_of_week,
  EXTRACT(WEEK FROM d)::smallint AS week_of_year,
  (EXTRACT(ISODOW FROM d) IN (6,7)) AS is_weekend,
  (date_trunc('month', d) = d::date) AS is_month_start,
  ((date_trunc('month', d) + interval '1 month - 1 day')::date = d::date) AS is_month_end
FROM generate_series(
  '2010-01-01'::date,
  '2020-12-31'::date,
  interval '1 day'
) d
ON CONFLICT (date_key) DO NOTHING;
SELECT COUNT(*) FROM dw.dim_date;
