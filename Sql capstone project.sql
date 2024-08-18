-- SQL CAPSTONE PROJECT

-- MOVIE RENTAL DATA ANALYSIS 

-- TASK 1
# DISPLAYING THE FULL NAMES OF THE ACTORS 

use sakila; -- Activating the sakila database

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name
FROM
    actor;
    

-- TASK 2
# (1) DISPLAYING THE COUNT OF FIRST NAMES

SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    actor
GROUP BY first_name
ORDER BY name_count DESC;

# We can see that Penelope, Julia, and Kenneth appears the maximum number of times.

#(2) DISPLAYING THE  COUNT OF ACTORS WHO HAVE UNIQUE FIRST NAME

SELECT 
    first_name, COUNT(first_name) AS name_count
FROM
    actor
GROUP BY first_name
HAVING name_count = 1;

# The code displays all the first names that are unique in the actors table. Out here Having is used to filter the names where the count is one which means those names are not repeated.



-- TASK 3
# (1) DISPLAYING THE COUNT OF LAST NAMES

SELECT 
    last_name, COUNT(last_name) AS last_count
FROM
    actor
GROUP BY last_name
ORDER BY last_count DESC;

# We can see that Kilmer, Nolte, and Temple appears the maximum number of times.

# (2) DISPLAYING TE UNIQUE LAST NAMES 

SELECT 
    last_name, COUNT(last_name) AS last_count
FROM
    actor
GROUP BY last_name
HAVING last_count = 1;

# The code displays the last names that are unique in the actor table, the names which are not repeated.alter


-- TASK 4
# (1) Dsiplaying the list of movies that are rated R

SELECT 
    title, rating
FROM
    film
WHERE
    rating = 'R';
    
# The output of this code displays the lsit of movies that are rated as R. Thse movies are not suitable for audience less than 17 years of age 
    

# (2) Displaying the list of movies which are not rated R

SELECT 
    title, rating
FROM
    film
WHERE
    rating <> 'R';
    
# The list of the movies whcih are not rated as R are displayed in the output of this code.

#(3) DISPLAYING THE LIST OF MOVIES THAT ARE SUITABLE FOR AUDIENCE WHO ARE LEE THAN 13 YEARS OF AGE

SELECT 
    title, rating
FROM
    film
WHERE
    rating = 'PG-13';
    
# The output displays the names of the movies that are rated PG-13, these movies are suitable for audience who are below 13 years of age.


-- 	TASK 5
# (1) DISPLAYING THE RECORDS OF MOVIES FOR WHICH REPLACEMENT COSTS ARE UPTO $11

select * from film;

SELECT 
    title, replacement_cost
FROM
    film
WHERE
    replacement_cost <= 11;
    
# The output shows the title and replacemnt cost of movies where the replacement costs are upto $11

# (2) LIST OF MOVIES WHERE THE REPLACEMENT COSTS ARE BETWEEN $11 AND $20.

select * from film;

SELECT 
    title, replacement_cost
FROM
    film
WHERE
    replacement_cost BETWEEN 11 AND 20;
    
    
# The output shows the list of the movies where the replacement costs are between $11 and $20.

#(3) DISPLAYING THE LIST OF ALL MOVIES IN DESCENDING ORDER OF THEIR REPLACEMENT COST

SELECT 
    *
FROM
    film
ORDER BY replacement_cost DESC;

# The output shows the list of all movies in descending order of their replacement cost


-- TASK 6
# DISPLAYING TEH TOP THREE MOVIES WITH THE GREATEST NUMBER OF ACTORS

SELECT * FROM film;
select * from film_actor;

SELECT 
    f.title, COUNT(fa.actor_id) AS total_actor
FROM
    film f
        JOIN
    film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title
ORDER BY total_actor DESC
LIMIT 3;

/*
The above code will display the top 3 film which has the highest number of actors.
To acomplish the above task the film and film actor table needed to be joined and count function to be applied to the actor id column.
If the code is written properly it must give the as the film title and number of actors in the film.
At last we need to order the output by the number of actors in descending order and to get the top 3 we need to limit it to 3
*/


-- TASK 7
# DISPLAYING THE RECORDS OF ALL MOVIES STARTING WITH K AND Q

SELECT 
    *
FROM
    film
WHERE
    title LIKE 'K%' OR title LIKE 'Q%';
    
# The output gives the records of all the movies where the title with either K or Q.alter

-- TASK 8
# DISPLAYING THE NAMES OF THE ACTORS WHO WERE A PART OF THE MOVIE AGENT TRUMAN

SELECT 
    a.first_name, a.last_name
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
WHERE
    fa.film_id = 6;
    
/*
The above code displays the names of the actors who were part of the film Agent Truman.
The Actor and Film actor tables need to be joined to get the desired result.
The film id of Agent Truman is 6 so at at last we ned to filter the film id with this to fetch the names.
*/

SELECT 
    *
FROM
    actor
WHERE
    actor_id IN (21 , 23, 62, 108, 137, 169, 197); -- to verify the output of the above code we can also run this code
    
    
-- TASK 9
# DISPLAYING THE LIST OF MOVIES WHICH ARE FAMILY FILMS

select * from film_category;
select * from category;

SELECT 
    f.title, c.name AS category
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
WHERE
    fc.category_id = 8;

/*
The above code displays the title if the movies the the categiry of the movie. The output includes all the movies which belong to the family category.
For achieving this task we join three table film, film_category and category.
*/

-- TASK 10
# (i) Display the maximum rental_rate, minimum rental rate, average rental rates of movies based on their ratings

select * from film;

SELECT 
    rating,
    MAX(rental_rate) AS max_rental_rate,
    MIN(rental_rate) AS min_rental_rate,
    AVG(rental_rate) AS avg_rental_rate
FROM
    film
GROUP BY rating
ORDER BY avg_rental_rate DESC;

/*
In the above task we have taken out the maximum, minimum, and average rental rates for the movies.
After that the output is grouped by the rating, these will give us the rental rates we want for each movie rating that is present in the database.
*/

# (ii) Display the movies in the descending order of the rental frequencies.

SELECT 
    f.title, COUNT(r.inventory_id) AS rental_count
FROM
    film f
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

/*
In the above code we have to join three tables to get our desired output.
The main part of the code in to use the count on inventory id, these give us the number of times a movie has been rented.
This will give us the movie names which names which which are rented frequently.
*/

-- Task 11: In how many film categories, the difference between the average film replacement cost and average film rental rate is greater than $15.

select * from film;

SELECT 
    c.name AS film_category,
    AVG(replacement_cost) AS avg_replacement_cost,
    AVG(rental_rate) AS avg_rental_rate,
    (AVG(replacement_cost) - AVG(rental_rate)) AS difference
FROM
    film f
        JOIN
    film_category fc ON f.film_id = fc.film_id
        JOIN
    category c ON fc.category_id = c.category_id
GROUP BY film_category
HAVING difference > 15;

/*
The above code join the three tables and filters the data where the difference between the average replacement cost and average rental rate is more than $15.
The average replacement cost and average rental rate are also displayed in the output.
*/

-- TASK 12: Display the film categories where the number of movies are greater than 70

SELECT 
    c.name AS fil_category,
    COUNT(fc.category_id) AS number_of_movies
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
HAVING number_of_movies > 70;

/*
The code counts the number of movies for each category. To achieve this task we have joined two tables film category and category.
As we can see there are only 2 categories where the number of movies are more than 7
*/



