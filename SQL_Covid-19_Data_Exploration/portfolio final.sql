select * 
from CovidVacinations
order by 3,4

select Location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
order by 1,2

--Looking at Total Cases vs Total Deaths 

select Location, date,new_cases, total_cases, total_deaths population
from CovidDeaths
order by 1,2


ALTER TABLE CovidDeaths ALTER COLUMN population float
ALTER TABLE CovidDeaths ALTER COLUMN total_cases float
ALTER TABLE CovidDeaths ALTER COLUMN new_deaths float
ALTER TABLE CovidDeaths ALTER COLUMN total_deaths float
ALTER TABLE CovidDeaths ALTER COLUMN new_cases_smoothed float
ALTER TABLE CovidDeaths ALTER COLUMN new_deaths_smoothed float
ALTER TABLE CovidDeaths ALTER COLUMN total_cases_per_million float
ALTER TABLE CovidDeaths ALTER COLUMN new_cases_per_million float
ALTER TABLE CovidDeaths ALTER COLUMN new_cases_smoothed_per_million float
ALTER TABLE CovidDeaths ALTER COLUMN total_deaths_per_million float
ALTER TABLE CovidDeaths ALTER COLUMN new_deaths_per_million float
ALTER TABLE CovidDeaths ALTER COLUMN new_deaths_smoothed_per_million float
ALTER TABLE CovidDeaths ALTER COLUMN reproduction_rate float
ALTER TABLE CovidDeaths ALTER COLUMN icu_patients float
ALTER TABLE CovidDeaths ALTER COLUMN icu_patients_per_million float
ALTER TABLE CovidDeaths ALTER COLUMN hosp_patients float
ALTER TABLE CovidDeaths ALTER COLUMN hosp_patients_per_million float
ALTER TABLE CovidDeaths ALTER COLUMN weekly_icu_admissions float
ALTER TABLE CovidDeaths ALTER COLUMN weekly_icu_admissions_per_million float
ALTER TABLE CovidDeaths ALTER COLUMN weekly_hosp_admissions float
ALTER TABLE CovidDeaths ALTER COLUMN weekly_hosp_admissions_per_million float

EXEC sp_help 'CovidDeaths'

ALTER TABLE CovidDeaths ALTER COLUMN total_cases INT
ALTER TABLE CovidDeaths ALTER COLUMN new_deaths INT
ALTER TABLE CovidDeaths ALTER COLUMN total_deaths INT
ALTER TABLE CovidDeaths ALTER COLUMN new_cases_smoothed INT
ALTER TABLE CovidDeaths ALTER COLUMN new_deaths_smoothed INT
ALTER TABLE CovidDeaths ALTER COLUMN total_cases_per_million INT
ALTER TABLE CovidDeaths ALTER COLUMN new_cases_per_million INT
ALTER TABLE CovidDeaths ALTER COLUMN new_cases_smoothed_per_million INT
ALTER TABLE CovidDeaths ALTER COLUMN total_deaths_per_million INT
ALTER TABLE CovidDeaths ALTER COLUMN new_deaths_per_millionnew_cases INT
ALTER TABLE CovidDeaths ALTER COLUMN new_deaths_smoothed_per_million INT
ALTER TABLE CovidDeaths ALTER COLUMN reproduction_rate INT
ALTER TABLE CovidDeaths ALTER COLUMN icu_patients INT
ALTER TABLE CovidDeaths ALTER COLUMN icu_patients_per_million INT
ALTER TABLE CovidDeaths ALTER COLUMN hosp_patients INT
ALTER TABLE CovidDeaths ALTER COLUMN hosp_patients_per_million INT
ALTER TABLE CovidDeaths ALTER COLUMN weekly_icu_admissions INT
ALTER TABLE CovidDeaths ALTER COLUMN weekly_icu_admissions_per_million INT
ALTER TABLE CovidDeaths ALTER COLUMN weekly_hosp_admissions INT
ALTER TABLE CovidDeaths ALTER COLUMN weekly_hosp_admissions_per_million INT