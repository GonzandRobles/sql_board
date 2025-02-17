with 

-- import data

    raw_course_lms as (

       select * from {{ source('raw_data', 'dim_course_lms') }}

    )

select * from raw_course_lms