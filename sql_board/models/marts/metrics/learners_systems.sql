with
-- import ctes

    leaners_lms as (

        -- Learning managemente system leraners
        select * from {{ ref('dim_learner_lms_marts') }}

    ),

    learners_sis as (

        -- Student information system learners
        select * from {{ ref('dim_learner_sis_marts') }}

    ),

    learners as (

        select * from {{ ref('fct_learners_marts') }}

    )

-- logical ctes

select 
    sis.sis_learner_id              as sis_learner_id,
    lms.lms_learner_id              as lms_learner_id,
    fct.is_hesi_testtaker           as is_hesi_testtaker,
    lms.learner_name                as lms_learner_name,
    sis.application_date            as sis_application_date,
    sis.last_date_of_attendance     as sis_last_date_of_attendance,
    lms.last_date_of_activity       as lms_last_date_of_activity,
    lms.created_at                  as lms_created_at,
    lms.updated_at                  as lms_updated_at,
    sis.created_at                  as sis_created_at,
    sis.updated_at                  as sis_updated_at
from learners as fct
left join leaners_lms as lms on fct.lms_learner_id = lms.lms_learner_id
left join learners_sis as sis on fct.sis_learner_id = sis.sis_learner_id