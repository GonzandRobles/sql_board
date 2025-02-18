{{ config(materialized='table') }}

select * from {{ ref('stg_course_enrollments_sis') }}