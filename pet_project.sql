CREATE DATABASE pet_project;

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	email VARCHAR(10000) NOT NULL,
	password_digest VARCHAR(10000)
);

-- add is_verified column

CREATE TABLE animals(
	user_id INTEGER,
	id SERIAL PRIMARY KEY,
	name VARCHAR(5000) NOT NULL,
	species VARCHAR(5000) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	animal_id INTEGER,
	image TEXT NOT NULL,
	FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE CASCADE
);

CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
	animal_id INTEGER,
	user_id INTEGER,
	FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);



-- SELECT id FROM animal INNER JOIN media ON animals.id = media.animal_id;