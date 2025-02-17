with 

-- import data

    raw_course_enrollments_sis as (

       select * from {{ source('raw_data', 'dim_course_enrollments_sis') }}

    )

select * from raw_course_enrollments_sis