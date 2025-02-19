with

    fact_learners as (

        select * from {{ ref('base_learners') }}

    ),

    sis_learners as (

        select * from {{ ref('base_learner_sis') }}
    
    ),

    lms_learners as (

        select * from {{ ref('base_learner_lms') }}

    )


SELECT 
    fl.*,
    ls.learner_name as sis_name,
    ll.learner_name as lms_name
FROM fact_learners as fl
LEFT JOIN sis_learners as ls ON fl.sis_learner_id = ls.sis_learner_id
LEFT JOIN lms_learners ll ON fl.lms_learner_id = ll.lms_learner_id