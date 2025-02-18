with

-- import cte

    b_learner_lms as (

        select * from {{ ref('base_learner_lms') }}

    ),

    final as (

        select
            lms_learner_id,
            learner_name,
            last_date_of_activity,
            created_at,
            updated_at
        from b_learner_lms

    )

select * from final