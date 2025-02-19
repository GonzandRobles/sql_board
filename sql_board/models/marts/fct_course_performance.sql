with

courses as (
    select * from {{ ref('stg_courses') }}
),

enrollments as (
    select * from {{ ref('stg_enrollments') }}
),

final as (
    select
        c.sis_course_id,
        c.lms_course_id,
        c.course_name,
        c.start_date,
        c.end_date,
        c.drop_date,

        count(distinct c.lms_course_enrollment_id) as total_enrollments,
        count(distinct case when c.has_passed_course then c.lms_course_enrollment_id end) as total_passes,
        count(distinct case when c.course_grade = 'F' then c.lms_course_enrollment_id end) as total_failures,

        round(avg(c.avg_test_score),2) as avg_test_score,
        round(avg(c.avg_quiz_score),2) as avg_quiz_score,
        round(avg(c.avg_assignment_time_to_complete),2) as avg_assignment_time,
        round(avg(c.grade),2) as avg_final_grade
    from courses c
    left join enrollments e on c.sis_course_id = e.program_id
    group by c.sis_course_id, c.lms_course_id, c.course_name, c.start_date, c.end_date, c.drop_date
)

select * from final