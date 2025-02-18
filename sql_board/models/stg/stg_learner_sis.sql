with

-- import cte

    b_learner_sis as (

        select * from {{ ref('base_learner_sis') }}

    ),

    final as (

        select
            sis_learner_id,
            learner_name,
            application_date,
            last_date_of_attendance,
            created_at,
            updated_at
        from b_learner_sis

    )

select * from final