-- task 2
/* возьмем произвольного пользователя с
id = 789 */
-- получение всех друзей произвольно выбранного пользователя для подзапроса
SELECT initiator_user_id FROM friend_requests
WHERE status = 'approved' AND target_user_id = 789
UNION
SELECT target_user_id FROM friend_requests
WHERE status = 'approved' AND initiator_user_id = 789;

-- выбор человека, который больше всех общался с выбранным пользователем
SELECT COUNT(id) AS amount, from_user_id FROM messages
WHERE from_user_id IN (SELECT initiator_user_id FROM friend_requests
                        WHERE status = 'approved' AND target_user_id = 789
                        UNION
                        SELECT target_user_id FROM friend_requests
                        WHERE status = 'approved' AND initiator_user_id = 789)
        AND to_user_id = 789
GROUP BY from_user_id
ORDER BY amount DESC
LIMIT 1;


-- task 3
SELECT COUNT(id) FROM likes
WHERE user_id IN (SELECT user_id FROM profiles
                  ORDER BY birthday DESC
                  LIMIT 10);
/* При выполнении запроса получил ошибку
ERROR (42000): This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'
поэтому нашел дату рождения 10-го самого молодого пользователя из использованного выше подзапроса и использовал ее для подзапроса
SELECT user_id FROM profiles
WHERE birthday >= '2020-07-25';
*/

-- вывод количества лайков для каждого из 10 самых молодых пользователей,
-- где видно что лайки есть не у каждого из них
SELECT COUNT(id), user_id FROM likes
WHERE user_id IN (SELECT user_id FROM profiles
                  WHERE birthday >= '2020-07-25')
GROUP BY user_id;

-- общее количество лайков, которые получили 10 самых молодых пользователей
SELECT COUNT(id) FROM likes
WHERE user_id IN (SELECT user_id FROM profiles
                  WHERE birthday >= '2020-07-25');


-- task 4
/* Для того, чтобы определить кто больше поставил лайков (всего) - мужчины или женщины,
сделал поочередно два запроса, в каждом из которых в подзапросе указывал свой пол
*/

SELECT COUNT(id) FROM likes
WHERE user_id IN (SELECT user_id FROM profiles
                  WHERE gender = 'm'); -- 608

SELECT COUNT(id) FROM likes
WHERE user_id IN (SELECT user_id FROM profiles
                  WHERE gender = 'f'); -- 815


-- task 5
/*
10 пользователей, которые проявляют наименьшую активность в публикации медиафайлов
*/
SELECT COUNT(id) AS amount_media, user_id FROM media
GROUP BY user_id
ORDER BY amount_media
LIMIT 10;

SELECT COUNT(id) AS amount_media, user_id FROM media
GROUP BY user_id
HAVING amount_media = 1;
-- получил 27 пользователей с наименьшим количеством медиафайлов

/*
10 пользователей, которые проявляют наименьшую активность в отправке сообщений
*/
SELECT COUNT(id) AS msgs, from_user_id FROM messages
GROUP BY from_user_id
ORDER BY msgs
LIMIT 10;

SELECT COUNT(id) AS msgs, from_user_id FROM messages
GROUP BY from_user_id
HAVING msgs = 3;
-- получил 67 пользователей с наименьшим количеством отправленных сообщений

/*
10 пользователей, которые проявляют наименьшую активность в отправке запросов дружбы
*/
SELECT COUNT(status) AS fr_rqs, initiator_user_id FROM friend_requests
WHERE status = 'requested'
GROUP BY initiator_user_id
ORDER BY fr_rqs
LIMIT 10;

/*
10 пользователей, которые проявляют наименьшую активность в создании фотоальбомов
*/
SELECT COUNT(id) AS albums, user_id FROM photo_albums
GROUP BY user_id
ORDER BY albums
LIMIT 10;

SELECT COUNT(id) AS albums, user_id FROM photo_albums
GROUP BY user_id
HAVING albums = 2;
-- получил 92 пользователей с наименьшим количеством альбомов

/*
10 пользователей, которые проявляют наименьшую активность в использовании групп
*/
SELECT COUNT(community_id) AS grps, user_id FROM users_communities
GROUP BY user_id
ORDER BY grps
LIMIT 10;

SELECT COUNT(community_id) AS grps, user_id FROM users_communities
GROUP BY user_id
HAVING grps = 1;
-- получил 177 пользователей, участвующих только в одной группе

/*
10 пользователей, которые проявляют наименьшую активность в лайках публикаций
*/
SELECT COUNT(id) AS wow, user_id FROM likes
GROUP BY user_id
ORDER BY wow
LIMIT 10;

SELECT COUNT(id) AS wow, user_id FROM likes
GROUP BY user_id
HAVING wow < 9;
-- получил 90 пользователей, поставивших менее 9 лайков
