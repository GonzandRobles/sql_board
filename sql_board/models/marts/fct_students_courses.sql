SELECT 
    s.sis_learner_id,
    s.lms_learner_id as student_lms_learner_id,
    s.sis_name,
    s.lms_name,
    s.is_hesi_testtaker,
    c.*
FROM {{ ref('stg_students') }} s
LEFT JOIN {{ ref('stg_courses') }} c ON s.lms_learner_id = c.lms_learner_id