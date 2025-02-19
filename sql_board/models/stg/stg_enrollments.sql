with

    enrollments as (

        select * from {{ ref('base_enrollments') }}

    ),

    dates as (

        select * from {{ ref('base_dates') }}

    )

SELECT 
    e.*,
    d1.year as start_year,
    d2.year as end_year
FROM enrollments as e
LEFT JOIN dates as d1 ON e.start_date = d1.date
LEFT JOIN dates as d2 ON e.graduation_date = d2.date