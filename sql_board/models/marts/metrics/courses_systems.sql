with
-- import ctes

    courses_lms as (

        -- Learning managemente system courses
        select * from {{ ref('dim_course_lms_marts') }}

    ),

    courses_sis as (

        -- Student information system courses
        select * from {{ ref('dim_course_enrollments_sis_marts') }}

    ),

    courses as (

        select * from {{ ref('fct_courses_marts') }}

    ),

    course_grades as (

        select * from {{ ref('dim_course_grades_marts') }}

    ),

    enrollments as (

        select * from {{ ref('dim_enrollments_marts') }}

    )

-- logical ctes

select distinct
    sis.sis_course_enrollment_id        as sis_course_enrollment_id,
    lms.lms_course_enrollment_id        as lms_course_enrollment_id,
    fct.learner_count                   as learner_count,
    lms.lms_learner_id                  as lms_learner_id,
    lms.most_recent_grade               as most_recent_grade,
    lms.avg_test_score                  as avg_test_score,
    lms.avg_quiz_score                  as avg_quiz_score,
    lms.avg_assignment_time_to_complete as avg_assignment_time_to_complete,
    sis.course_name                     as course_name,
    sis.start_date                      as start_date,
    sis.end_date                        as end_date,
    sis.drop_date                       as drop_date,
    sis.course_grade                    as course_grade,
    sis.has_passed_course               as has_passed_course,
    cg.course_grade_id                  as course_grade_id,
    cg.course_grade_type                as course_grade_type,
    cg.status                           as status,
    cg.course_grade_name                as course_grade_name,
    cg.grade                            as grade,
    cg.is_passing_grade                 as is_passing_grade,
    ers.learner_id                      as learner_id,
    ers.program_id                      as program_id,
    ers.start_date                      as enrollment_start_date,
    ers.drop_date                       as enrollment_drop_date,
    ers.withdrawal_date                 as enrollment_withdrawal_date,
    ers.graduation_date                 as enrollment_graduation_date
from courses_lms as lms
left join courses_sis as sis  on lms.sis_course_enrollment_id = sis.sis_course_enrollment_id
left join courses as fct      on lms.sis_course_enrollment_id = fct.lms_course_id
left join course_grades as cg on lms.lms_course_enrollment_id = cg.lms_course_enrollment_id
-- joining with dim_course_enrollments_sis since it looks like it might be student related
left join enrollments as ers  on sis.sis_course_enrollment_id = ers.enrollment_id