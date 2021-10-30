
/*
Covid 19 Data Exploration 

Skills used: 

Steps Used:
	1- Find the first countries to record Covid 19 Cases


*/

-- 1-Query the first countries to record Covid-19 Cases in the world

select location, total_cases, total_deaths,  new_cases, population
from ['CovidDeaths$']
where (total_cases IS NOT NULL) AND
		(CONVERT(DATETIME, FLOOR(CONVERT(FLOAT, date))) = '2020-01-22') AND 
		(location Not IN ('North America','Asia','World','Africa'))
order by  date, new_cases;


-- 2- Query the location and population of countries which has population > countries count
select location, population
from ['CovidDeaths$']
where population > (select (COUNT(distinct(location))) as countries_count 
from ['CovidDeaths$'])


/**
	select location and the total cases of egypt and order them by total cases
**/
SELECT location,(total_cases/population)*100 AS total_cases_ratio
FROM ['CovidDeaths$']
where (total_cases is not null) and (location in ('andorra', 'Egypt', 'Morocco'))
order by location desc


-- QUERY the country with highest population
select location, max(population) as max_population
from ['CovidDeaths$']
where 
	(population > 100000000) 
	and 
	(location not in ('world','asia','Africa','North America','South America')) 
group by location 
order by max_population desc

OFFSET  0 ROWS 
FETCH NEXT 1 ROWS ONLY 