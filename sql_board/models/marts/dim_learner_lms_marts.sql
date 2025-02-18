{{ config(materialized='table') }}

select * from {{ ref('stg_learner_lms') }}