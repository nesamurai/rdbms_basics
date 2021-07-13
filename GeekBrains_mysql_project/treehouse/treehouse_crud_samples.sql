-- inserts
INSERT INTO instructors(name, bio)
VALUES ('Kenneth Love', 'He created a few popular Python libraries, worked at most levels of the web stack, & was the Creative Director of a newspaper.');

INSERT INTO instructors(name, bio)
VALUES ('Andrew Chalkley', "All of my professional life I've worked with computers online. I'm a polyglot programmer and like using the right tools for the job.");


INSERT INTO topics(name, teacher_id)
VALUES ('Python', 1), ('Databases', 2);


INSERT INTO tracks(name)
VALUES ('Intermediate Python'), ('Learn React');


INSERT INTO courses(course_name, duration_in_min, teacher_id, topic_id, level, description)
VALUES ('Django Forms', 249, 1, 1, 'Intermediate', 'Django Forms let us quickly create HTML forms and validate information from users and APIs.');

INSERT INTO courses(course_name, duration_in_min, teacher_id, topic_id, level, description)
VALUES ('Python Testing', 77, 1, 1, 'Intermediate', "In this course, we'll learn about doctests, Python's unittest library, and the super-handy third-party package coverage.py.");

INSERT INTO courses(course_name, duration_in_min, teacher_id, topic_id, track_id, level, description)
VALUES ('Regular Expressions in Python', 110, 1, 1, 1, 'Intermediate', "In this course, we'll explore the re module that Python provides and learn to write regular expressions for many different situations.");

INSERT INTO courses(course_name, duration_in_min, teacher_id, topic_id, level, description)
VALUES ('SQL Basics', 172, 2, 2, 'Beginner', "In SQL Basics we’ll take a look at what databases are and how you can retrieve information from them.");


INSERT INTO steps(name, badge_id, course_id, status, number_of_steps)
VALUES ('Forms', 1, 1, 'initial', 13);


INSERT INTO achievements(name, course_id, user_id)
VALUES ('Django Forms', 1, 1);


INSERT INTO users(fullname, registered_at)
VALUES ('Anton Petrov', '09.09.2020'), ('Maria Subbotina', '29.05.2021');


INSERT INTO completed_courses(course_id, user_id, points_achieved)
VALUES (2, 1, 224), (3, 1, 223);


INSERT INTO profiles(first_name, last_name, email_address, password, profile_name, country, spoken_language, user_id)
VALUES ('Anton', 'Petrov', 'anton.petrov@yandex.ru', 'jkUI23lkj', 'antonpetrov3', 'RU', 'russian', 1);

INSERT INTO profiles(first_name, last_name, email_address, password, profile_name, country, spoken_language, user_id)
VALUES ('Maria', 'Subbotina', 'm.subbotina@mail.ru', '7438urei_jDD', 'mariasubbotina2', 'RU', 'russian', 2);


INSERT INTO subscription_plans(plan_name, plan_price, plan_content)
VALUES ('Courses', '$25/mo', '300+ high quality video courses, Interactive tools, On-demand learning, Supportive community of students'),
('Courses Plus', '$49/mo', 'All features of the Courses plan, plus: Enjoy exclusive bonus content, Download videos for offline learning'),
('Techdegree', '$100/mo', 'All features of the Courses and Courses Plus plans, plus: A portfolio of 12 real-world projects, graded and with personalized feedback, Techdegree-only content to help you create a resume, build a professional network and conduct a successful job search, Step-by-step guided curriculum to prepare you for a job in the tech industry, A final exam to test and verify your knowledge, Treehouse Certification to showcase on your resume');


INSERT INTO subscription(plan_id, user_id)
VALUES (1, 1), (1, 2);


INSERT INTO billing_history(user_id, 'Inv no.', date_of_payment, amount)
VALUES (1, '77855038', '12.09.2020', 29.99), (1, '77899430', '12.10.2020', 29.99);


INSERT INTO bookmarks(course_id, user_id)
VALUES (4, 2);


-- Изменим план подписки у пользователя
UPDATE subscription
SET plan_id = 2
WHERE user_id = 2;
