with

-- import ctes

    fact_learners as (

        select * from {{ ref('base_learners') }}

    ),

    sis_learners as (

        select * from {{ ref('base_learner_sis') }}
    
    ),

    lms_learners as (

        select * from {{ ref('base_learner_lms') }}

    )


select 
    fl.*,
    ls.learner_name as sis_name,
    ll.learner_name as lms_name,
    ll.last_date_of_activity
from fact_learners as fl
left join sis_learners as ls on fl.sis_learner_id = ls.sis_learner_id
left join lms_learners ll on fl.lms_learner_id = ll.lms_learner_id