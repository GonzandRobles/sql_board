with

students as (
    select * from {{ ref('stg_students') }}
),

enrollments as (
    select * from {{ ref('stg_enrollments') }}
),

courses as (
    select * from {{ ref('stg_courses') }}
),

final as (
    select
        s.sis_learner_id,
        s.lms_learner_id,
        s.sis_name,
        s.lms_name,
        s.last_date_of_activity,
        s.is_hesi_testtaker,
        
        e.program_id,
        e.start_date,
        e.drop_date,
        e.withdrawal_date,
        e.graduation_date,
        e.start_year,
        e.drop_year,
        e.withdrawal_year,
        e.graduation_year,

        count(distinct c.sis_course_enrollment_id) as total_courses_enrolled,
        sum(case when c.has_passed_course then 1 else 0 end) as total_courses_passed,
        round(avg(c.avg_test_score),2) as avg_test_score,
        round(avg(c.avg_quiz_score),2) as avg_quiz_score,
        round(avg(c.avg_assignment_time_to_complete),2) as avg_assignment_time
    from students s
    left join enrollments e on s.sis_learner_id = e.learner_id
    left join courses c on s.sis_learner_id = c.lms_learner_id
    group by
        s.sis_learner_id, s.lms_learner_id, s.sis_name, s.lms_name, s.last_date_of_activity, s.is_hesi_testtaker,
        e.program_id, e.start_date, e.drop_date, e.withdrawal_date, e.graduation_date,
        e.start_year, e.drop_year, e.withdrawal_year, e.graduation_year
)

select * from final
