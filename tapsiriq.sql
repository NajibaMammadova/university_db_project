-- 1. Database yaratmaq
CREATE DATABASE university_db;

-- 2. Cədvəlləri yaratmaq
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    department VARCHAR(50)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    grade INT
);
-- Tələbə əlavə etmək
INSERT INTO students (first_name, last_name, age, city) VALUES 
('Ali', 'Aliyev', 21, 'Baku'),
('Aysel', 'Mammadova', 19, 'Ganja'),
('Vugar', 'Hasanov', 22, 'Baku');

-- Kurs əlavə etmək
INSERT INTO courses (course_name, department) VALUES 
('Database Systems', 'IT'),
('Project Management', 'HR'),
('Programming', 'IT');

-- Qeydiyyat və qiymət əlavə etmək
INSERT INTO enrollments (student_id, course_id, grade) VALUES 
(1, 1, 95), -- Ali, Database Systems, 95
(2, 1, 88), -- Aysel, Database Systems, 88
(3, 3, 75); -- Vugar, Programming, 75
SELECT s.first_name, s.last_name, s.city
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Database Systems';
SELECT s.first_name, s.last_name, e.grade
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
ORDER BY e.grade DESC;
SELECT c.course_name, COUNT(e.student_id) AS telebe_sayi
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
SELECT city, COUNT(student_id) AS telebe_sayi
FROM students
GROUP BY city;
SELECT first_name, last_name
FROM students
WHERE age > 20
ORDER BY first_name ASC;
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.department = 'IT'
ORDER BY e.grade DESC;
