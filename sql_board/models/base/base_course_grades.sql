with 

-- import data

    raw_course_grades as (

       select * from {{ source('raw_data', 'dim_course_grades') }}

    )

select * from raw_course_grades