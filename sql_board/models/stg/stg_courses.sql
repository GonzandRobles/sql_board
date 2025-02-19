with

-- import ctes

    fact_courses as (

        select * from {{ ref('base_courses') }}

    ),

    enrollments_sis as (

        select * from {{ ref('base_course_enrollments_sis') }}

    ),

    course_lms as (

        select * from {{ ref('base_course_lms') }}

    ),

    grades as (

        select * from {{ ref('base_course_grades') }}

    )

select 
    fc.sis_course_id,
    fc.lms_course_id,
    fc.learner_count,
    cl.lms_course_enrollment_id,
    cl.sis_course_enrollment_id,
    cl.lms_learner_id,
    cl.most_recent_grade,
    cl.avg_test_score,
    cl.avg_quiz_score,
    cl.avg_assignment_time_to_complete,
    ces.course_name,
    ces.start_date,
    ces.drop_date,
    ces.end_date,
    ces.course_grade,
    ces.has_passed_course,
    cg.course_grade_id,
    cg.course_grade_type,
    cg.status,
    cg.grade,
    cg.is_passing_grade
from fact_courses as fc
left join course_lms as cl       on fc.lms_course_id = cl.lms_course_enrollment_id
left join enrollments_sis as ces on cl.sis_course_enrollment_id = ces.sis_course_enrollment_id
left join grades as cg           on cl.lms_course_enrollment_id = cg.lms_course_enrollment_id