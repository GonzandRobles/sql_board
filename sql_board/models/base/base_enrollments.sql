with 

-- import data

    raw_enrollments as (

       select
            enrollment_id,
            learner_id,
            program_id,
            start_date::date as start_date,
            drop_date::date as drop_date,
            withdrawal_date::date as withdrawal_date,
            graduation_date::date as graduation_date
       from {{ source('raw_data', 'dim_enrollments') }}

    )

select * from raw_enrollments