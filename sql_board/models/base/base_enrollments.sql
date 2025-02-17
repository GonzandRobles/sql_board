with 

-- import data

    raw_enrollments as (

       select * from {{ source('raw_data', 'dim_enrollments') }}

    )

select * from raw_enrollments