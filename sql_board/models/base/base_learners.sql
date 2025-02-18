with 

-- import data

    raw_courses as (

       select * from {{ source('raw_data', 'fact_learner') }}

    )

select * from raw_courses