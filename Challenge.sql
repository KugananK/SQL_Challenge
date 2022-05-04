--list all actors
SELECT First_name, Last_name From actor;

--Find the surname of the actor with the forename 'John'
SELECT last_name FROM actor WHERE first_name IN ('John'); 

--Find all actors with the surname 'Neeson'
SELECT * From actor WHERE last_name IN ('Neeson');

--Find all actors with ID numbers divisible by 10
SELECT * FROM actor WHERE actor_id LIKE'%0';

--What is the description of the movie with an ID of 100?
SELECT DISTINCT description FROM film WHERE film_id = '100';

--Find ever R-rated movie
SELECT * FROM film WHERE rating = 'R';

--Find every non-R-rated movie
Select * FROM film WHERE rating != 'R';

--Find the 10 shortest movies
Select * FROM film ORDER BY length ASC LIMIT 10;

--Find the movies with the longest runtime, without using LIMIT
SELECT *
FROM film
WHERE length =(
    SELECT MAX(length)
    FROM film
);

--FInd all movies that have deleted scenes
SELECT * FROM film WHERE special_features = 'Deleted Scenes';

--USING HAVING, reverse-alphabetiacally list the last names that are not repeated
SELECT last_name FROM actor GROUP BY last_name 
HAVING COUNT(last_name) = 1 ORDER BY last_name DESC; 
-- need to try doing the joining one for this^

--Using Having, list the last names that appear more than once, from highest to lowest frequency
SELECT last_name, COUNT(last_name) FROM actor group by last_name HAVING COUNT(last_name) > 1 ORDER BY COUNT(last_name) DESC;

--Which actor has appeared in the most films
SELECT * FROM actor 
JOIN film_actor ON film_actor.actor_id=actor.actor_id 
HAVING COUNT(film_actor.actor.id)
ORDER BY COUNT(film_actor.actor_id) DESC LIMIT 1;

--'Academy dinosaur'