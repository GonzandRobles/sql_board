SELECT 
    s.sis_learner_id,
    s.lms_learner_id,
    s.sis_name,
    s.lms_name,
    s.is_hesi_testtaker,
    e.*
FROM {{ ref('stg_students') }} s
LEFT JOIN {{ ref('stg_enrollments') }} e 
    ON s.sis_learner_id = e.learner_id