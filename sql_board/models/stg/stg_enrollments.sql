with

-- import ctes

    enrollments as (

        select * from {{ ref('base_enrollments') }}

    ),

    dates as (

        select * from {{ ref('base_dates') }}

    )

select 
    e.enrollment_id,
    e.learner_id,
    e.program_id,
    e.start_date,
    e.drop_date,
    e.withdrawal_date,
    e.graduation_date,
    max(case when e.start_date = d.date then d.year end) as start_year,
    max(case when e.drop_date = d.date then d.year end) as drop_year,
    max(case when e.withdrawal_date = d.date then d.year end) as withdrawal_year,
    max(case when e.graduation_date = d.date then d.year end) as graduation_year
from enrollments as e
left join dates as d on e.start_date = d.date or e.drop_date = d.date
                                              or e.withdrawal_date = d.date
                                              or e.graduation_date = d.date
group by
    e.enrollment_id,
    e.learner_id,
    e.program_id,
    e.start_date,
    e.drop_date,
    e.withdrawal_date,
    e.graduation_date