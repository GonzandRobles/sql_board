{{ config(materialized='table') }}

select * from {{ ref('stg_course_grades') }}