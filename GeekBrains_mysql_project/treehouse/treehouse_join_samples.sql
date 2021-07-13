-- 1. Посчитаем количество набранных очков за пройденные курсы у определенного
-- пользователя по определенному топику.
SELECT SUM(points_achieved), t.name, u.fullname FROM topics t
    INNER JOIN courses c ON t.id = c.topic_id
    INNER JOIN completed_courses cc ON c.id = cc.course_id
    INNER JOIN users u ON users.id = cc.user_id
WHERE t.name = 'Python' AND u.fullname = 'Anton Petrov'
GROUP BY t.name, u.fullname;

-- 2. Выберем только те курсы, у которых определенный топик
SELECT c.course_name, t.name FROM courses c
    INNER JOIN topics t ON c.topic_id = t.id
WHERE t.name = 'Development Tools';

-- 3. Найдем какие топики ведет определенный преподаватель
SELECT i.name, DISTINCT t.name FROM instructors i
    INNER JOIN topics t ON i.id = t.teacher_id
WHERE i.name = 'Ashley Boucher';

-- 4. Посчитаем общее количество видео, заданий, тестов в опреденном курсе
SELECT SUM(number_of_steps) AS all_tasks, course_name FROM steps
    INNER JOIN courses ON steps.course_id = courses.id
WHERE course_name = 'Functions, Packing, and Unpacking'
GROUP BY course_name;

-- 5. Отберем курсы, составляющие определенный трек
SELECT c.course_name, t.name FROM courses c
    INNER JOIN tracks t ON c.track_id = t.id
WHERE t.name = 'Advanced Android';

-- 6. Посчитаем время трека, сложив время каждого из входящих в него курсов
SELECT SUM(c.duration_in_min) AS total_time, t.name FROM courses c
    INNER JOIN tracks t ON c.track_id = t.id
WHERE t.name = 'Advanced Android'
GROUP BY t.name;
