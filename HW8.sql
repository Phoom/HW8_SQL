USE sakila;


-- 1a. Display the first and last names of all actors from the table actor.
select first_name,	
			last_name
from actor;
									
-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
DROP VIEW IF EXISTS actorName;

CREATE VIEW actorName 
AS SELECT concat(first_name, ' ', last_name) as 'Actor Name'
from actor;

SELECT * FROM actorName;


-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you use to obtain this information?

select 	actor_id,
			first_name,	
			last_name
from actor
where first_name = 'Joe';


-- 2b. Find all actors whose last name contain the letters GEN:
select 	first_name,	
			last_name
from actor
where last_name like '%gen%';

-- 2c. Find all actors whose last names contain the letters LI. 
-- This time, order the rows by last name and first name, in that order:
select 	first_name,	
			last_name
from actor
where last_name like '%li%'
order by last_name, first_name;


-- 2d. Using IN, display the country_id and country columns of the following countries: 
-- Afghanistan, Bangladesh, and China:
select 	country_id,
			country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');


-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. 
-- Hint: you will need to specify the data type.
ALTER TABLE actor
ADD column middle_name varchar(30) after first_name;

select * from actor;


-- 3b. You realize that some of these actors have tremendously long last names. 
-- Change the data type of the middle_name column to blobs.
Alter table actor change middle_name middle_name blob;


-- 3c. Now delete the middle_name column.
ALTER TABLE actor
  DROP COLUMN middle_name;


-- 4a. List the last names of actors, as well as how many actors have that last name.

SELECT last_name,COUNT(*) as 'Amount'
       FROM actor
       GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name,COUNT(*) as 'Amount'
       FROM actor
       GROUP BY last_name
       Having COUNT(*) > 2;




-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as 
-- GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.

UPDATE actor 
SET first_name = "HARPO"
WHERE actor_id = 172;

select 	actor_id,
			first_name,
			last_name
from actor
where actor_id = 172;



-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! 
-- In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, 
-- as that is exactly what the actor will be with the grievous error. 
-- BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO 
-- MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)