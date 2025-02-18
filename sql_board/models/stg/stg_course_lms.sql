with

    b_course_lms as(

        select * from {{ ref('base_course_lms') }}

    ),    
    
    final as(

        select
            lms_course_enrollment_id,
            sis_course_enrollment_id,
            lms_learner_id,
            most_recent_grade,
            avg_test_score,
            avg_quiz_score,
            avg_assignment_time_to_complete
        from b_course_lms

    )

select * from final