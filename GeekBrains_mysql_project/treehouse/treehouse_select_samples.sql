-- 1. Посчитаем количество пройденных курсов определенным пользователем
SELECT COUNT(*) FROM completed_courses
WHERE user_id = 1;

-- 2. Выберем пользователей сайта, проживающих в России
SELECT first_name, last_name FROM profiles
WHERE country = 'RU';

-- 3. Выберем пользователей, зарегистрированных в 2020 году
SELECT fullname, YEAR(registered_at) AS last_year FROM users
WHERE last_year = 2020;

-- 4. С помощью подзапроса выберем курсы для начинающих, которые ведет опеределенный преподаватель
SELECT course_name, level FROM courses
WHERE teacher_id = (SELECT id FROM instructors
                    WHERE name = 'Jay McGavren')
    AND level = 'Beginner';

-- 5. Подзапрос для вычисления общего числа выполненных курсов у каждого пользователя в порядке убывания
SELECT fullname, (SELECT COUNT(*) FROM completed_courses cc
                    WHERE cc.user_id = users.id) AS amount_courses
FROM users
ORDER BY amount_courses DESC;
