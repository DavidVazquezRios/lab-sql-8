use sakila;
#1 Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT title,length , rank() OVER (order by length desc) AS "Row_length"
FROM film
where length != 0 or length != null
order by length;

#2 Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
SELECT title,length, rating, rank() OVER (partition by rating order by length desc) AS "Rank" 
FROM film
where length != 0 or length != null
;

#3 How many films are there for each of the categories in the category table. Use appropriate join to write this query
SELECT 
    C.category_id, COUNT(F.film_id) AS num_films
FROM
    category AS C
        INNER JOIN
    film_category AS F ON C.category_id = F.category_id
GROUP BY category_id
;

#4 Which actor has appeared in the most films?
SELECT 
    A.first_name, A.last_name, COUNT(B.film_id) AS num_films
FROM
    actor AS A
        INNER JOIN
    film_actor AS B ON A.actor_id = B.actor_id
GROUP BY A.actor_id , A.first_name , A.last_name
ORDER BY num_films DESC
LIMIT 1
;

#5 Most active customer (the customer that has rented the most number of films)
SELECT 
    A.first_name,
    A.last_name,
    A.customer_id,
    COUNT(B.rental_id) AS num_films_rented
FROM
    customer AS A
        INNER JOIN
    rental AS B ON A.customer_id = B.customer_id
GROUP BY A.customer_id , A.first_name , A.last_name
ORDER BY num_films_rented DESC
LIMIT 1
;
