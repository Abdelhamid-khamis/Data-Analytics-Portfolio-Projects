/**
	
**/
/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

Steps Used:
	1- Create 2 Tables(CovidDeaths.xlsx & CovidVaccinations.xlsx)  from the Covid19 TotalData table


*/


-- select the columns date and location and total_cases,
--		from the table (covid deaths) and order them by the location then date
SELECT date, location, total_cases, total_deaths,  new_cases, population
FROM ['CovidDeaths$']
order by location, date


-- Looking at the Max deaths_cases Vs the diagnosed_cases percentage for all countries

SELECT location, MAX(((total_deaths / total_cases ) * 100)) AS max_deaths_percentage_per_case
FROM ['CovidDeaths$']
WHERE (
	total_deaths IS NOT NULL 
	--location = 'Egypt'
)
group by location
ORDER BY max_deaths_percentage_per_case desc



-- Looking at the mean deaths_cases to the diagnosed_cases percentage for all countries

SELECT location, AVG(((total_deaths / total_cases ) * 100)) AS mean_deaths_percentage_per_case
FROM ['CovidDeaths$']
WHERE (
	total_deaths IS NOT NULL
	--location = 'Egypt'
)
group by location
ORDER BY mean_deaths_percentage_per_case desc

-- Looking at the percentage of covid cases Vs population(Covid Cases percentage for a specific country)

SELECT date, location, population, total_cases, (total_cases / population) *100 as cases_percentage
FROM ['CovidDeaths$']
WHERE location like 'egy%'
ORDER BY cases_percentage desc, date desc;


-- Looking at the percentage of new covid cases Vs population(New Covid Cases percentage for a specific country)

SELECT date, location, population, new_cases, (new_cases / population) * 100 as new_cases_percentage
FROM ['CovidDeaths$']
WHERE location like 'egy%'
ORDER BY new_cases desc, date desc;


-- Finding the country with the highest infection rate(total cases / population) compared to population

SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases / population)) * 100 
as percentage_of_population_infected
FROM ['CovidDeaths$']
GROUP BY location, population
ORDER BY percentage_of_population_infected desc;


-- Finding the country with the highest infection rate in more than 100M Countries' population

SELECT location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases / population)) * 100 
as percentage_of_population_infected
FROM ['CovidDeaths$']
WHERE	population > 100000000 AND 
		location NOT IN ('North America','South America','Europe','European Union','World','Asia','Africa')
GROUP BY location, population
ORDER BY percentage_of_population_infected desc;


-- Finding the Countries with the highest total deaths
-- we'll find that total_deaths col is nvar char so, we need to cast it to int

SELECT location, population, MAX(cast(total_deaths as int)) as highest_total_deaths
FROM ['CovidDeaths$']
WHERE	 
		continent IS NOT null
GROUP BY location, population
ORDER BY highest_total_deaths desc;

-- LET'S BREAK DOWN THINGS BY CONTINENT


SELECT location, MAX(cast(total_deaths as int)) as highest_total_deaths
FROM ['CovidDeaths$']
WHERE	 
		continent IS null
GROUP BY location
ORDER BY highest_total_deaths desc;