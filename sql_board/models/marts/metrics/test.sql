with

-- Import SIS learner data
learner_sis as (
    select
        sis_learner_id,
        learner_name,
        application_date,
        last_date_of_attendance
    from {{ ref('dim_learner_sis_marts') }}
),

-- Import LMS learner data
learner_lms as (
    select
        lms_learner_id,
        last_date_of_activity
    from {{ ref('dim_learner_lms_marts') }}
),

-- Import enrollment data
enrollments as (
    select
        learner_id,
        program_id,
        start_date,
        drop_date,
        withdrawal_date,
        graduation_date
    from {{ ref('dim_enrollments_marts') }}
),

-- Import course enrollments data
course_enrollments as (
    select
        sis_course_enrollment_id,
        learner_id,
        has_passed_course
    from {{ ref('dim_course_enrollments_sis_marts') }}
),

-- Import LMS course performance data
course_lms as (
    select
        lms_course_enrollment_id,
        lms_learner_id,
        avg_test_score,
        avg_quiz_score,
        avg_assignment_time_to_complete
    from {{ ref('dim_course_lms_marts') }}
),

-- Import grades data
course_grades as (
    select
        lms_course_enrollment_id,
        grade
    from {{ ref('dim_course_grades_marts') }}
),

-- Aggregate learner course performance
learner_performance as (
    select
        ce.learner_id,
        count(distinct ce.sis_course_enrollment_id) as total_courses_enrolled,
        sum(case when ce.has_passed_course then 1 else 0 end) as total_courses_passed,
        round(avg(cl.avg_test_score),2) as avg_test_score,
        round(avg(cl.avg_quiz_score),2) as avg_quiz_score,
        round(avg(cl.avg_assignment_time_to_complete),2) as avg_assignment_time
    from course_enrollments ce
    left join course_lms cl on ce.learner_id = cl.lms_learner_id
    group by ce.learner_id
),

-- Join all datasets into the final fact table
final as (
    select 
        ls.sis_learner_id,
        ll.lms_learner_id,
        ls.learner_name,
        ls.application_date,
        ls.last_date_of_attendance,
        e.program_id,
        e.start_date,
        e.drop_date,
        e.withdrawal_date,
        e.graduation_date,
        lp.total_courses_enrolled,
        lp.total_courses_passed,
        lp.avg_test_score,
        lp.avg_quiz_score,
        lp.avg_assignment_time
    from learner_sis ls
    left join learner_lms ll on ls.sis_learner_id = ll.lms_learner_id
    left join enrollments e on ls.sis_learner_id = e.learner_id
    left join learner_performance lp on ls.sis_learner_id = lp.learner_id
)

select * from final
