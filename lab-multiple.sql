
# Lab | SQL Joins on multiple tables

use sakila;

#1. Write a query to display for each store its store ID, city, and country.
select s.store_id, ci.city, co.country from sakila.country as co
join sakila.city as ci
on co.country_id = ci.country_id
join sakila.address as ad
on ad.city_id = ci.city_id
join sakila.store as s
on s.address_id = ad.address_id;
 
#2. Write a query to display how much business, in dollars, each store brought in.
select so.store_id, sum(p.amount) as dollars from sakila.store as so
join sakila.staff as sa
on so.store_id = sa.store_id
join sakila.payment as p
on p.staff_id = sa.staff_id
group by so.store_id;

#3. What is the average running time of films by category?
select c.category_id, ca.name, round(avg(f.length),2) as average_length from sakila.film as f
join sakila.film_category as c
on f.film_id = c.film_id
join sakila.category as ca
on ca.category_id = c.category_id
group by c.category_id, ca.name order by round(avg(f.length),2) desc;

#4. Which film categories are longest?
select c.category_id, ca.name, round(sum(f.length),2) as total_length from sakila.film as f
join sakila.film_category as c
on f.film_id = c.film_id
join sakila.category as ca
on ca.category_id = c.category_id
group by c.category_id, ca.name order by round(sum(f.length),2) desc;

#5. Display the most frequently rented movies in descending order.
select f.film_id, f.title, count(rental_id) as total_rental from sakila.rental as r
join sakila.inventory as i
on i.inventory_id = r.inventory_id
join sakila.film as f
on f.film_id = i.film_id
group by f.film_id, f.title order by count(rental_id) desc;

#6. List the top five genres in gross revenue in descending order.
select c.category_id, ca.name as category, round(sum(p.amount),2) as gross_revenue from sakila.film as f
join sakila.film_category as c
on f.film_id = c.film_id
join sakila.category as ca
on ca.category_id = c.category_id
join sakila.inventory as i
on i.film_id =f.film_id
join sakila.rental as r
on r.inventory_id = i.inventory_id
join sakila.payment as p
on p.rental_id=r.rental_id
group by c.category_id, ca.name order by round(sum(p.amount),2) desc limit 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?
select f.film_id, f.title, f.store_id, i.inventory_id from sakila.film as f
join inventory as i
on i.film_id = f.film_id
join store as s 
on s.store_id = i.store_id
where f.title = 'Academy Dinosaur' and s.store_id=1;









