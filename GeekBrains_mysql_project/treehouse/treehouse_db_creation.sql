-- table 1
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
    FOREIGN KEY teacher_id REFERENCES instructors(id),
    FOREIGN KEY topic_id REFERENCES topics(id),
    FOREIGN KEY track_id REFERENCES tracks(id),
);

-- table 2
DROP TABLE IF EXISTS steps;
CREATE TABLE steps (
    id SERIAL PRIMARY KEY,
    name VARCHAR(128),
    badge_id DEFAULT NULL,
    course_id INT UNSIGNED NOT NULL,
    status ENUM('initial', 'completed'),
    number_of_steps INT UNSIGNED NOT NULL COMMENT 'Количество видео, заданий, тестов для завершения шага',
    FOREIGN KEY course_id REFERENCES courses(id),
);

-- table 3
DROP TABLE IF EXISTS instructors;
CREATE TABLE instructors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    bio TEXT,
    photo
);

-- table 4
DROP TABLE IF EXISTS achievements;
CREATE TABLE achievements (
    id SERIAL PRIMARY KEY,
    step_name VARCHAR(128),
    course_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    achieved_at DATETIME DEFAULT NOW(),
    FOREING KEY step_name REFERENCES steps(name),
    FOREING KEY course_id REFERENCES courses(id),
    FOREING KEY user_id REFERENCES users(id)
);

-- table 5
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    fullname VARCHAR(255),
    registered_at DATETIME NOT NULL,
    total_points INT DEFAULT 0
);

-- table 6
DROP TABLE IF EXISTS completed_courses;
CREATE TABLE completed_courses (
    course_id INT UNSIGNED NOT NULL,
    points_achieved INT UNSIGNED,
    user_id INT UNSIGNED NOT NULL,
    FOREIGN KEY course_id REFERENCES courses(id),
    FOREIGN KEY user_id REFERENCES users(id)
);

-- table 7
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    password VARCHAR(16),
    profile_name VARCHAR(255),
    country CHAR(2),
    spoken_language VARCHAR(128),
    user_id INT UNSIGNED NOT NULL,
    FOREIGN KEY user_id REFERENCES users(id),
    INDEX idx_first_and_last_names(first_name, last_name)
);

-- table 8
DROP TABLE IF EXISTS subscription;
CREATE TABLE subscription (
    id SERIAL PRIMARY KEY,
    plan_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    FOREIGN KEY plan_id REFERENCES subscription_plans(id),
    FOREIGN KEY user_id REFERENCES users(id)
);

-- table 9
DROP TABLE IF EXISTS subscription_plans;
CREATE TABLE subscription_plans (
    id SERIAL PRIMARY KEY,
    plan_name VARCHAR(100),
    plan_price CHAR(6),
    plan_content TEXT
);

-- table 10
DROP TABLE IF EXISTS billing_history;
CREATE TABLE billing_history (
    id SERIAL PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    'Inv no.' CHAR(8),
    date_of_payment DATETIME,
    payment_status VARCHAR(32) DEFAULT 'Paid',
    amount DECIMAL(8,2),
    pdf_file,
    FOREIGN KEY user_id REFERENCES users(id)
);

-- table 11
DROP TABLE IF EXISTS tracks;
CREATE TABLE tracks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- table 12
DROP TABLE IF EXISTS topics;
CREATE TABLE topics (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    teacher_id INT UNSIGNED,
    FOREIGN KEY teacher_id REFERENCES instructors(id)
);

-- table 13
DROP TABLE IF EXISTS bookmarks;
CREATE TABLE bookmarks (
    id SERIAL,
    course_id INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    has_bookmark CHAR(1) DEFAULT '1',
    FOREIGN KEY course_id REFERENCES courses(id),
    FOREIGN KEY user_id REFERENCES users(id)
);
