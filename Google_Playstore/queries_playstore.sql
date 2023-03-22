-- Comments in SQL Start with dash-dash --

-- 1. Find the app with an ID of 1880 --
SELECT * 
FROM analytics WHERE id = 1880;

-- 2. Find the ID and app name for all apps that were last updated on August 01, 2018 --
SELECT id, app_name 
FROM analytics WHERE last_updated ='08-01-2018';

-- 3. Count the number of apps in each category, e.g. "Family | 1972" --
SELECT category AS family, COUNT(*) AS number 
FROM analytics 
GROUP BY category;

-- 4. Find the top 5 most-reviewed apps and the number of reviews for each. --
SELECT app_name, reviews 
FROM analytics 
ORDER BY reviews DESC LIMIT 5;

-- 5. Find the app that has the most reviews with a rating greater than equal to 4.8 --
SELECT app_name, reviews ,rating  
FROM analytics WHERE rating >=4.8;

-- 6. Find the average rating for each category ordered by the highest rated to lowest rated --
SELECT category , avg(rating) 
FROM analytics 
GROUP BY category 
ORDER BY AVG(rating) DESC;

-- 7. Find the name, price and rating of the most expensive app with a rating thats less than 3 --
SELECT app_name, price, rating
FROM analytics
WHERE rating < 3
GROUP BY price,app_name,rating  
HAVING price = max(price) 
ORDER BY price DESC LIMIT 1;

-- 8. Find all apps with a min install not exceeding 50, that have a rating. Order your results by highest rated first --
SELECT app_name ,min_installs ,rating  
FROM analytics WHERE min_installs <= 50 AND rating >0 
ORDER BY rating DESC;

-- 9. Find the names of all that are rated less than 3 with at least 10000 reviews --
SELECT app_name,rating ,reviews 
FROM analytics 
WHERE rating < 3 AND reviews >= 10000;

-- 10. Find the top 10 most-reviewed apps that cost between 10 cents and a dollar --
SELECT app_name ,price ,reviews  
FROM analytics 
WHERE price BETWEEN 0.10 AND 1 
ORDER BY reviews DESC LIMIT 10;

-- 11. Find the most out of date app. --
SELECT * FROM analytics 
WHERE last_updated  = (
   SELECT MIN (last_updated)
   FROM analytics 
) LIMIT 1;

-- 12. Find the most expensive app (The query is very similar to 11) --
SELECT * FROM analytics 
WHERE price  = (
   SELECT MAX (price)
   FROM analytics 
) LIMIT 1;

-- 13. Count all the reviews in the Google Play store --
SELECT SUM(reviews) 
FROM analytics;

-- 14. Find all the categories that have more than 300 apps in them --
SELECT category,COUNT(*) as number_of_app 
FROM analytics 
GROUP BY category HAVING COUNT(*) > 300;

-- 15. Find the app that has the highest proportion of min_installs to reviews, 
-- among apps that have been installed at least 100,000 times. Display the name
-- of the app along with the number of reviews, the min_installs and the proportion --

SELECT app_name ,reviews ,min_installs ,min_installs/reviews AS proportion 
FROM analytics  WHERE min_installs/reviews =(SELECT MAX(min_installs/reviews) AS proportion FROM analytics);