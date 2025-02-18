with

    b_cesis as (

        select * from {{ ref('base_course_enrollments_sis') }}

    ),

    final as (

        select
            sis_course_enrollment_id,
            course_name,
            start_date,
            drop_date,
            end_date,
            course_grade,
            has_passed_course
        from b_cesis

    )

select * from final

