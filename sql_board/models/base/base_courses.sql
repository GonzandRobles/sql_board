with 

-- import data

    raw_learners as (

       select * from {{ source('raw_data', 'fact_courses') }}

    )

select * from raw_learners