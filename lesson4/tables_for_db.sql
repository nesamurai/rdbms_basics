CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100),
	phone BIGINT UNSIGNED UNIQUE,
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

CREATE TABLE media_types (
	id SERIAL,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE media (
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

CREATE TABLE `profiles` (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
	FOREIGN KEY (photo_id) REFERENCES media(id),
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE messages (
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

CREATE TABLE friend_requests (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

CREATE TABLE `photo_albums` (
	id SERIAL,
	name varchar(255) DEFAULT NULL,
    user_id BIGINT UNSIGNED DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

CREATE TABLE photos (
	id SERIAL,
	album_id BIGINT unsigned,
	media_id BIGINT unsigned NOT NULL,
	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

CREATE TABLE communities (
	id SERIAL,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	INDEX communities_name_idx(name),
	FOREIGN KEY (admin_user_id) REFERENCES users(id)
);

CREATE TABLE users_communities (
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (user_id, community_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

CREATE TABLE likes (
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (media_id) REFERENCES media(id)
);

CREATE TABLE games (
    id SERIAL,
	user_id BIGINT UNSIGNED DEFAULT NULL,
    name VARCHAR(255),
    description TEXT,
    genre VARCHAR(128),
    rating DOUBLE(2,1),
    size INT,
    community_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (community_id) REFERENCES communities(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE notifications (
    id SERIAL,
    received_at DATETIME DEFAULT NOW(),
    community_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

CREATE TABLE events (
    id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    planned_at DATETIME DEFAULT NOW(),
    attend ENUM('+', '+/-', '-'),
    category_of_event ENUM('birthday', 'party', 'health', 'business', 'sport', 'theatre'),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
