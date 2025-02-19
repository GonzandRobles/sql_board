with

enrollments as (
    select * from {{ ref('stg_enrollments') }}
),

courses as (
    select * from {{ ref('stg_courses') }}
),

final as (
    select
        e.program_id,
        e.start_year,
        e.drop_year,
        e.withdrawal_year,
        e.graduation_year,

        count(distinct e.enrollment_id) as total_enrollments,
        count(distinct case when e.drop_date is not null then e.enrollment_id end) as total_drops,
        count(distinct case when e.withdrawal_date is not null then e.enrollment_id end) as total_withdrawals,
        count(distinct case when e.graduation_date is not null then e.enrollment_id end) as total_graduates,

        round(100 * count(distinct case when e.graduation_date is not null then e.enrollment_id end) 
               / count(distinct e.enrollment_id),2) as graduation_rate,

        round(100 * count(distinct case when e.drop_date is not null then e.enrollment_id end) 
               / count(distinct e.enrollment_id),2) as dropout_rate
    from enrollments e
    left join courses c on e.program_id = c.sis_course_id
    group by e.program_id, e.start_year, e.drop_year, e.withdrawal_year, e.graduation_year
)

select * from final