with

-- import cte

    b_learners as (

        select * from {{ ref('base_learners') }}

    ),

    final as (

        select 
            sis_learner_id,
            lms_learner_id,
            is_hesi_testtaker
        from b_learners

    )

select * from final