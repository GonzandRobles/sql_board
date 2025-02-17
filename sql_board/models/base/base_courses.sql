with 

-- import data

    raw_learners as (

       select * from {{ source('raw_data', 'fact_learner') }}

    )

select * from raw_learners