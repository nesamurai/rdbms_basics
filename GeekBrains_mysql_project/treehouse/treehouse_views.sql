-- 1. Создадим представление, в котором показываются все курсы для начинающих
CREATE VIEW courses_for_beginners AS
SELECT course_name, duration_in_min, courses.teacher_id, topics.name, tracks.name, description
FROM courses INNER JOIN topics ON courses.topic_id = topics.id
                INNER JOIN tracks ON courses.track_id = tracks.id
WHERE level = 'Beginner';

-- 2. Создадим представление, в котором показываются пользователи из России
-- с их данными профиля, у которых более 10000 очков
CREATE VIEW russian_users AS
SELECT first_name, last_name, email_address, profile_name, spoken_language,
        user_id, registered_at, total_points
FROM users INNER JOIN profiles ON users.id = profiles.user_id
WHERE country = 'RU' AND total_points > 10000;

-- 3. Создадим представление со всеми курсами с топиком Python, в котором покажем пройденные у определенного пользователя
CREATE VIEW python_courses AS
SELECT c.course_name, c.duration_in_min, c.level, c.description,
        cc.points_achieved FROM courses c INNER JOIN topics t ON c.topic_id = t.id
        LEFT JOIN completed_courses cc ON c.id = cc.course_id
WHERE t.name = 'Python' AND cc.user_id = 1;
