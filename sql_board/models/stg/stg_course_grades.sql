with

    b_course_grades as (

        select * from {{ ref('base_course_grades') }}

    ),

    final as (

        select 
            course_grade_id,
            lms_course_enrollment_id,
            course_grade_type,
            course_grade_name,
            grade,
            is_passing_grade
        from b_course_grades

    )

select * from final