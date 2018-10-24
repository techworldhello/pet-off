CREATE DATABASE pet_project;

# one owner to mulitple pets
# one pet to multple pics (of same pet)
# one pic to many likes 

CREATE TABLE animals(
	user_id INTEGER,
	id SERIAL PRIMARY KEY,
	name VARCHAR(5000) NOT NULL,
	species VARCHAR(5000) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE media(
	animal_id INTEGER,
	image TEXT NOT NULL,
	FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE CASCADE
);

SELECT id FROM animal INNER JOIN media ON animals.id = media.animal_id;

-- only show images frmo animal_with_image, also record animal_id??

-- put the below in ruby
CONSTRAINT chk_media CHECK (image_url IS NOT NULL OR video_url IS NOT NULL)

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	email VARCHAR(10000) NOT NULL,
	password_digest VARCHAR(10000)
);

INSERT INTO users (email, password_digest) VALUES ('jessie@email.com', 'pizza');

CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
	animal_id INTEGER,
	user_id INTEGER,
	FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);