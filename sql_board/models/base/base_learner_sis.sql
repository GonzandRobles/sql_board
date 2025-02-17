with 

-- import data

    raw_learner_sis as (

       select * from {{ source('raw_data', 'dim_learner_sis') }}

    )

select * from raw_learner_sis