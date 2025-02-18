with

-- import cte

    b_courses as (

        select * from {{ ref('base_courses') }}

    ),

-- transformations

    final as (

        select
            sis_course_id,
            lms_course_id,
            learner_count
        from b_courses

    )

select * from final