with

-- import cte

    b_enrollments as (

        select * from {{ ref('base_enrollments') }}

    ),

    final as (

        select
            enrollment_id,
            learner_id,
            program_id,
            start_date,
            drop_date,
            withdrawal_date,
            graduation_date
        from b_enrollments

    )

select * from final
