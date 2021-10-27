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