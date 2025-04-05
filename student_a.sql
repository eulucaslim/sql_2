SELECT school.name AS school_name, 
    student.enrolled_at AS enrollment_date,  
    COUNT(student.id) AS len_student, 
    SUM(course.price) AS total_price FROM students student
JOIN courses course ON student.course_id = course.id
JOIN schools school ON course.school_id = s.id
WHERE course.name LIKE 'data%' 
GROUP BY school.name, student.enrolled_at  
ORDER BY enrollment_date DESC;
