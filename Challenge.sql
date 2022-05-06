---SAKILA CHALLENGE
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
HAVING COUNT(last_name) >= 1 ORDER BY last_name DESC; 
-- need to try doing the joining one for this^

--Using Having, list the last names that appear more than once, from highest to lowest frequency
SELECT last_name, COUNT(last_name) FROM actor group by last_name HAVING COUNT(last_name) > 1 ORDER BY COUNT(last_name) DESC;

--Which actor has appeared in the most films
SELECT first_name, last_name, COUNT(*) FROM actor
JOIN film_actor ON actor.actor_id=film_actor.actor_id
GROUP BY actor.actor_id ORDER BY COUNT(*) DESC LIMIT 1;

--'Academy dinosaur' has been rented out, when is it due to be returned?
SELECT film.title, rental.rental_date, DATE_ADD(rental.rental_date, INTERVAL film.rental_duration day) FROM rental
JOIN inventory ON rental.inventory_id=inventory.inventory_id
JOIN film ON inventory.film_id=film.film_id
WHERE rental.return_date IS NULL AND rental.inventory_id BETWEEN 1 AND 8; 

--What is the average runtime of all films?
SELECT AVG(length) FROM film;

--List the average runtime for every film catergory
SELECT category.name,AVG(film.length) FROM category
JOIN film_category ON category.category_id=film_category.category_id
JOIN film ON film_category.film_id=film.film_id
GROUP BY category.category_id;

--List all movies featuring a robot
SELECT title FROM film WHERE description LIKE '%Robot%';

--How many movies were released in 2010?
SELECT COUNT(release_year) FROM film WHERE release_year = 2010;

--Find the titles of all the horror movies
SELECT film.title FROM Category
JOIN film_category ON category.category_id=film_category.category_id
JOIN film ON film_category.film_id=film.film_id
WHERE category.category_id = '11';

--List the name of the staff member with the ID of 2
SELECT first_name, last_name FROM Staff WHERE staff_id = '2';

--List all the movies Fred Costner has appeared in
SELECT film.title FROM actor
JOIN film_actor ON actor.actor_id=film_actor.actor_id
JOIN film ON film_actor.film_id=film.film_id
WHERE actor.actor_id = '16';

--How many distinct countires are there?
SELECT DISTINCT COUNT(country_id) FROM country;

--List the name of every language in reverse-alphabetical order
SELECT name FROM language ORDER BY name DESC;

--List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%son' 
ORDER BY first_name ASC;

--Which category contains the most films?
SELECT category.name, COUNT(film.film_id) FROM category
JOIN film_category ON category.category_id=film_category.category_id
JOIN film ON film_category.film_id=film.film_id
GROUP BY category.category_id ORDER BY COUNT(film.film_id) DESC LIMIT 1;


---WORLD CHALLENGE
--Using COUNT, get the number of cities in the USA
SELECT COUNT(ID) FROM city WHERE CountryCode = 'USA';

--Find out the population and life expectancy for people in Argentina
SELECT name, Population, LifeExpectancy FROM country WHERE name = 'Argentina';

--Using IS NOT NULL, ORDER BY and LIMIT, which country has the highest life expectancy?
SELECT Name, LifeExpectancy FROM country WHERE LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy DESC LIMIT 1;

--Using Join ON, find the capital city of Spain
SELECT City.Name FROM Country
JOIN City ON country.capital=city.ID
WHERE country.name = 'Spain';

--Using JOIN ON, list all the langauages spoken in the Southeast Asia region
SELECT CountryLanguage.Language FROM Country
JOIN CountryLanguage ON Country.Code=CountryLanguage.CountryCode
WHERE Country.region = 'Southeast Asia';

--Using a single query, list 25 cities around the world that start with the letter F
SELECT Name from City WHERE Name like 'F%' LIMIT 25;

--Using COUNT and JOIN, get the number of cities in China
SELECT COUNT(city.ID) FROM Country
JOIN City ON Country.code=city.CountryCode
WHERE city.CountryCode = 'CHN';

--Using IS NOT NULL, ORDER BY and LIMIT, which country has the lowest population? Discard non-zero populations
SELECT Name, Population From country ORDER BY population IS NOT NULL ASC LIMIT 1;

--Using aggregate functions, return the number of countries the database contains
SELECT COUNT(Code) FROM country;

--What are the top 10 largest countries by area?
SELECT Name FROM country ORDER BY surfaceArea DESC LIMIT 10;

--List the 5 largest cities by population in japan
SELECT Name FROM city WHERE countrycode = 'JPN'
ORDER BY Population DESC LIMIT 5;

--List the name and country codes of every country with Elizabeth II as it's head of state. You will need to fix the mistake first.
UPDATE Country
SET HeadOfState = replace(HeadOfState,'Elisabeth II','Elizabeth II')
SELECT Name, Code FROM country WHERE HeadOfState = 'Elizabeth II';

--List the top 10 countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0
SELECT name, Population/SurfaceArea as Ratio FROM COUNTRY
WHERE population !=0 ORDER BY Ratio ASC LIMIT 10;

--List every unique world language.
SELECT DISTINCT Language FROM CountryLanguage;

--List the name and GNP of the world's top 10 richest countries
SELECT Name, GNP FROM country ORDER BY GNP DESC LIMIT 10;

--list the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT Country.Name, COUNT(countrylanguage.Language) FROM CountryLanguage 
Join country ON CountryLanguage.Countrycode=Country.code
GROUP BY Country.Name
ORDER BY COUNT(countrylanguage.Language) DESC LIMIT 10;

--list every country where over 50% of its population can speak German
SELECT COUNTRY.Name From CountryLanguage
JOIN Country ON CountryLanguage.Countrycode=Country.code
WHERE Language = 'GERMAN' AND Percentage > 50;

--Which country has the worst life expectancy? Discard zero nad null values.
SELECT Name, LifeExpectancy FROM Country WHERE LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy ASC LIMIT 1;

--List the top 3 most common government forms
SELECT GovernmentForm, COUNT(Code) FROM country 
GROUP BY GovernmentForm
ORDER BY COUNT(Code) DESC LIMIT 3;

--How many countries have gained independance since records began?
SELECT COUNT(Code) FROM Country WHERE IndepYear IS NOT NULL;


---MOVIELENS CHALLENGE
--List the titles and release dates of movies released between 1983-1993 in reverse chronological order
SELECT title, release_date From movies WHERE release_date
BETWEEN '1983-01-01' AND '1993-01-01'
ORDER BY release_date ASC;

---NEED HELP
--Without using LIMIT, list the titles of the movies with the lowest average rating
SELECT movies.title, avg(ratings.rating) AS AVG_ratings FROM ratings 
JOIN movies ON ratings.movie_id=movies.id
GROUP BY movies.title
HAVING AVG_ratings = (
    SELECT MIN() FROM ratings
    GROUP BY movies.id
)
ORDER BY AVG_ratings;
-- ASK for help
SELECT * FROM (SELECT movies.title , AVG(rating) 
AS avg_rating FROM ratings 
JOIN movies on ratings.movie_id=movies.id 
GROUP BY movies.id) sub  
WHERE avg_rating=(SELECT MIN(avg_rating) FROM (SELECT movies.title , AVG(rating) 
AS avg_rating FROM ratings 
JOIN movies on ratings.movie_id=movies.id 
GROUP BY movies.id) sub );
---NEED HELP

--List the unique records for Sci-Fi movies where male 24-year-old students have given 5 star ratings
SELECT movies.title FROM movies
JOIN ratings ON movies.id=ratings.movie_id
JOIN users ON ratings.user_id=users.id
JOIN occupations ON users.occupation_id=occupations.id
JOIN genres_movies ON movies.id=genres_movies.movie_id
JOIN genres ON genres_movies.genre_id=genres.id
WHERE genres.name = 'Sci-Fi' AND users.gender = 'm'
AND users.age = '24' AND occupations.name = 'student'
AND ratings.rating = '5';

--List the unique titles of each of the movies released on the most popular release day
SELECT title FROM movies
WHERE release_date = (
    SELECT release_date FROM movies
    GROUP BY release_date ORDER BY count(id) DESC LIMIT 1
);

--Find th etotla number of movies in each genre; list the results in ascending numeric order
SELECT genres.name, COUNT(movies.id) FROM movies
JOIN genres_movies ON movies.id=genres_movies.movie_id
JOIN Genres ON genres_movies.genre_id=genres.id
GROUP BY genres.id ORDER BY COUNT(movies.id) ASC;