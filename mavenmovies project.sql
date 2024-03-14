use mavenmovies;

-- Q1: write a sql query to count the number of characters of actors Fullname except for the spaces for each actor.
-- Return the first 10 actors' name length along with their name
-- SOLUTION 1:
SELECT 
    first_name,
    (CONCAT(first_name, last_name)) AS fullname,
    LENGTH(CONCAT(first_name, last_name)) AS fullname_length
FROM
    actor
LIMIT 10;

-- Q:2 List all the oscar awardees (actors who received the oscar awards) with their full names and length of 
-- their names
-- Solution 2:
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LENGTH(CONCAT(first_name, last_name)) AS fullname_length
FROM
    actor_award
WHERE
    awards LIKE 'oscar';
-- Q3: Find the actors who have acted in the film 'Frost Head'
-- solution 3:
SELECT 
    CONCAT(first_name, ' ', last_name) AS actors_fullname
FROM
    actor
        INNER JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
        INNER JOIN
    film ON film_actor.film_id = film.film_id
WHERE
    title = 'frost head';
    
-- q 4: Pull all the films acted by the actor 'Will Wilson'
-- solution 4:
SELECT 
    title
FROM
    film
        INNER JOIN
    film_actor ON film.film_id = film_actor.film_id
        INNER JOIN
    actor ON film_actor.actor_id = actor.actor_id
WHERE
    CONCAT(first_name, ' ', last_name) = 'Will Wilson';

-- q5:Pull all the films which were rented and return them in the month of may
-- solution 5:

SELECT 
    title, return_date
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
        INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
WHERE
    MONTHNAME(return_date) = 'may';

-- q6:Pull all the films with 'comedy' category
-- solution 6:
SELECT 
    title, name
FROM
    film
        INNER JOIN
    film_category ON film.film_id = film_category.film_id
        INNER JOIN
    category ON film_category.category_id = category.category_id
WHERE
    name = 'comedy';





