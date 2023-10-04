--Author: Jeffrey Emmons
--     1. How many rows are in the data_analyst_jobs table?

SELECT COUNT(*) AS count_all
FROM data_analyst_jobs;

-- ANSWER: 1793

--     2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- ANSWER: ExxonMobil

--     3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT COUNT(*) AS count_tn_ky
FROM data_analyst_jobs
WHERE location = 'TN'
OR location = 'KY';

-- ANSWERS: 21; 27

--     4. How many postings in Tennessee have a star rating above 4?

SELECT COUNT(*) AS count_tn_over_4stars
FROM data_analyst_jobs
WHERE location = 'TN'
AND star_rating > 4;

-- ANSWER: 3

--     5. How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(*) AS count_bt_500_1k
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- ANSWER: 151

--     6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?

SELECT 
	location,
	AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY AVG(star_rating) DESC;

-- ANSWER: NE

--     7. Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT title) AS count_unique_titles
FROM data_analyst_jobs;

-- ANSWER: 881

--     8. How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title) AS count_unique_ca_titles
FROM data_analyst_jobs
WHERE location = 'CA';

-- ANSWER: 230

--     9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT
	company,
	SUM(review_count) AS review_amount,
	AVG(star_rating) AS avg_company_rating
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count) > 5000;

-- ANSWER: 71

--     10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT
	company,
	SUM(review_count) AS review_amount,
	AVG(star_rating) AS avg_company_rating
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count) > 5000
ORDER BY avg_company_rating DESC;

--ANSWERS: Google; 4.3

--     11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?

SELECT COUNT(DISTINCT title) AS count_analyst_titles
FROM data_analyst_jobs
WHERE LOWER(title) LIKE '%analyst%';

-- ANSWER: 774

--     12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT COUNT(DISTINCT title) AS count_not_analyst_titles
FROM data_analyst_jobs
WHERE LOWER(title) NOT LIKE '%analyst%'
AND LOWER(title) NOT LIKE '%analytics%';

-- ANSWERS: 4; Tableau

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.

--     *Disregard any postings where the domain is NULL.
--     *Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
--     *Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT
	domain,
	COUNT(title) AS amount_of_jobs
FROM data_analyst_jobs
WHERE domain IS NOT NULL
AND days_since_posting > 21
AND skill LIKE '%SQL%'
GROUP BY domain
ORDER BY amount_of_jobs DESC
LIMIT 4;

-- ANSWERS: 'Internet and Software' 62, 'Banks and Finanial Services' 61, 'Consulting and Business Services' 57, 'Health Care' 52