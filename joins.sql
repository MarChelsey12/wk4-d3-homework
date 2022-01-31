-- 1. List all customers who live in Texas (use JOINs) 
SELECT first_name, last_name
FROM customer
JOIN "address"
ON customer.address_id = "address".address_id
WHERE "address".district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name 
SELECT customer.first_name, customer.last_name, amount 
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99 
ORDER BY amount DESC;

-- 3. Show all customers names who have made payments over $175(use subqueries) 
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id, SUM(amount)
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) >= 175
    ORDER BY SUM(amount)
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT customer.first_name, customer.last_name, country
FROM customer
JOIN "address"
ON customer.address_id = "address".address_id
JOIN city
ON "address".city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country.country = 'Nepal';

-- 5. Which staff member had the most transactions? 
SELECT staff.first_name, staff.last_name, SUM(amount)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name
ORDER BY SUM(amount) DESC;

-- 6. How many movies of each rating are there? 
SELECT count(film_id), rating 
FROM film
GROUP BY rating
ORDER BY rating;


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer_id, amount
FROM payment
WHERE amount = 6.99
ORDER BY customer_id;

-- 8. How many free rentals did our stores give away?
SELECT rental_id, amount
FROM payment
GROUP BY rental_id, amount
HAVING amount = 0
ORDER BY rental_id;
