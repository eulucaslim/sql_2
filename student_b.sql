WITH registration_per_day AS (
    SELECT school.name AS school_name, 
		student.enrolled_at AS enrollment_date, 
		COUNT(student.id) AS len_student FROM students student
    JOIN courses course ON student.course_id = course.id
    JOIN schools school ON course.school_id = school.id
    WHERE course.name LIKE 'data%'
    GROUP BY school.name, student.enrolled_at
)
SELECT 
    school_name, 
    enrollment_date,
    len_student,
    SUM(len_student) OVER (PARTITION BY school_name ORDER BY enrollment_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum,
    AVG(len_student) OVER (PARTITION BY school_name ORDER BY enrollment_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS avg_7_days,
    AVG(len_student) OVER (PARTITION BY school_name ORDER BY enrollment_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS avg_30_days
FROM 
    registration_per_day
ORDER BY 
    enrollment_date DESC;
