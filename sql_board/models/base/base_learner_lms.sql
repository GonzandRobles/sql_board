with 

-- import data

    raw_learner_lms as (

       select * from {{ source('raw_data', 'dim_learner_lms') }}

    )

select * from raw_learner_lms