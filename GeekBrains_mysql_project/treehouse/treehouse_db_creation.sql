DROP DATABASE IF EXISTS treehouse;
CREATE DATABASE treehouse;
USE treehouse;

-- table 1
-- таблица содержит данные по курсам, где стоблцами являются
-- назавание курса, длительность, ид_преподавателя, ид_топика, ид_трека
-- уровень, описание и очки за курс
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    duration_in_min INT,
    teacher_id INT UNSIGNED NOT NULL,
    topic_id INT UNSIGNED NOT NULL,
    track_id INT UNSIGNED DEFAULT NULL,
    level ENUM('Beginner', 'Intermediate', 'Advanced'),
    description TEXT,
    points INT DEFAULT 0,
    FOREIGN KEY (teacher_id) REFERENCES instructors(id),
    FOREIGN KEY (topic_id) REFERENCES topics(id),
    FOREIGN KEY (track_id) REFERENCES tracks(id),
);

-- table 2
-- в таблице содержатся стоблцы с названием шага, ид_значка за прохождение шага,
-- ид_курса, к которому принадлежит шаг, статус шага (на начат или завершен),
-- количество заданий и видео в шаге
DROP TABLE IF EXISTS steps;
CREATE TABLE steps (
    id SERIAL PRIMARY KEY,
    name VARCHAR(128),
    badge_id DEFAULT NULL,
    course_id INT UNSIGNED NOT NULL,
    status ENUM('initial', 'completed'),
    number_of_steps INT UNSIGNED NOT NULL COMMENT 'Количество видео, заданий, тестов для завершения шага',
    FOREIGN KEY (course_id) REFERENCES courses(id),
);

-- table 3
-- данные о преподавателях, где столбец bio - краткая справка
DROP TABLE IF EXISTS instructors;
CREATE TABLE instructors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    bio TEXT
);

-- table 4
-- в таблице содержится достижение за пройденный шаг, какому курсу соответствует,
-- ид_пользователя, когда достигнуто
DROP TABLE IF EXISTS achievements;
CREATE TABLE achievements (
    id SERIAL PRIMARY KEY,
    step_id INT UNSIGNED NOT NULL,
    course_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    achieved_at DATETIME DEFAULT NOW(),
    FOREING KEY (step_id) REFERENCES steps(id),
    FOREING KEY (course_id) REFERENCES courses(id),
    FOREING KEY (user_id) REFERENCES users(id)
);

-- table 5
-- пользователи с датой регистрации и общими очками за пройденные курсы
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    fullname VARCHAR(255),
    registered_at DATETIME NOT NULL,
    total_points INT DEFAULT 0
);

-- table 6
-- завершенные курсы по пользователям с очками за курс
DROP TABLE IF EXISTS completed_courses;
CREATE TABLE completed_courses (
    course_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    points_achieved INT UNSIGNED,
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- table 7
-- данные профиля пользователей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
    first_name VARCHAR(128),
    last_name VARCHAR(128),
    email_address VARCHAR(128),
    password VARCHAR(16),
    profile_name VARCHAR(128),
    country CHAR(2),
    spoken_language VARCHAR(128),
    user_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX idx_first_and_last_names(first_name, last_name)
);

-- table 8
-- сооветствие подписки и пользователя
DROP TABLE IF EXISTS subscription;
CREATE TABLE subscription (
    id SERIAL PRIMARY KEY,
    plan_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (plan_id) REFERENCES subscription_plans(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- table 9
-- типы подписок с назаванием, ценой и что включает
DROP TABLE IF EXISTS subscription_plans;
CREATE TABLE subscription_plans (
    id SERIAL PRIMARY KEY,
    plan_name VARCHAR(100),
    plan_price CHAR(7),
    plan_content TEXT
);

-- table 10
-- история платежей пользователя, с номером оплаты,
-- днем оплаты, статусом оплаты, стоимостью
DROP TABLE IF EXISTS billing_history;
CREATE TABLE billing_history (
    id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    'Inv no.' CHAR(8),
    date_of_payment DATETIME,
    payment_status VARCHAR(32) DEFAULT 'Paid',
    amount DECIMAL(8,2),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- table 11
-- названия треков
-- несколько курсов составляют трек
DROP TABLE IF EXISTS tracks;
CREATE TABLE tracks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- table 12 содержит названия топиков курсов, например Python или Databases, и
-- id преподавателей по топикам
DROP TABLE IF EXISTS topics;
CREATE TABLE topics (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    teacher_id INT UNSIGNED,
    FOREIGN KEY (teacher_id) REFERENCES instructors(id)
);

-- table 13
-- запланированные курсы по пользователям, где столбец has_bookmark
-- работает как true/false
DROP TABLE IF EXISTS bookmarks;
CREATE TABLE bookmarks (
    id SERIAL,
    course_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    has_bookmark CHAR(1) DEFAULT '1',
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
