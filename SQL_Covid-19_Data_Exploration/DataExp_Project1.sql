
--Looking at the Total cases vs Total Deaths  
--shows likehood of dying if you contract covid  

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths 
order by 1,2

--Looking at Total cases vs Population
--Shows what percentage of population got covid 

select location, date, population, total_cases, (total_cases/population)*100 as PercentageTotalCase
from CovidDeaths 
order by 1,2

--Looking at countries with highest infection rate compared to population
select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))* 100 as PercentagePopulationInfected
from CovidDeaths 
group by location, population
order by PercentagePopulationInfected desc


--Showing countries with the highest death count per population
select location, population, MAX(total_deaths) as TotalDeathCount
from CovidDeaths
where continent is not NULL
group by location, population
order by TotalDeathCount desc

-- SHOWING COUNTRIES WITH THE HIHGEST DEATH COUNT PER POPULATION
select continent, MAX(total_deaths) as TotalDeathCount
from CovidDeaths
where continent is not NULL
group by continent
order by TotalDeathCount desc

--GLOBAL NUMBERS 
--Total cases and deaths and per day 

select date, SUM(new_cases) as total_cases , SUM(cast(new_deaths as int)) as total_deaths, SUM(new_deaths)/SUM (cast(new_cases as int)) *100 as TotalDeaths 
from CovidDeaths 
--where location = 'south africa'
where continent is not null
group by date 
order by 1,2


--Global death percentage 
select SUM(new_cases) as total_cases , SUM(cast(new_deaths as int)) as total_deaths, SUM(new_deaths)/SUM (cast(new_cases as int)) *100 as TotalDeaths 
from CovidDeaths 
--where location = 'south africa'
where continent is not null
order by 1,2


--Looking at total populations vs vaccinations 

select * 
from CovidDeaths dea
JOIN  CovidVaccinations vac
on dea.location = vac.location AND dea.date = dea.date

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from CovidDeaths dea
JOIN  CovidVaccinations vac
on dea.location = vac.location AND dea.date = dea.date
where dea.continent is not null
order by 1,2


--USE CTE 
WITH PopvsVac (continent , location, date, population, new_vaccinations, RollingPeopleVaccinated )
as (
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as float)) OVER ( partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
from CovidDeaths dea
JOIN  CovidVaccinations vac
on dea.location = vac.location AND dea.date = dea.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/population)*100
from PopvsVac

--TEMP TABLE 
drop table if exists PercentPopulationVaccinated

CREATE TABLE PercentPopulationVaccinated(
continent nvarchar(255),
Location nvarchar (255),
Date datetime,
population numeric, 
new_vaccinated numeric,
RollingPeopleVaccinated numeric)


insert into PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as float)) OVER ( partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
from CovidDeaths dea
JOIN  CovidVaccinations vac
on dea.location = vac.location AND dea.date = dea.date
where dea.continent is not null

select *, (RollingPeopleVaccinated/population)*100
from PercentPopulationVaccinated


--creating view to store data for later visualisations

create view TotalDeathCount as
select continent, MAX(total_deaths) as TotalDeathCount
from CovidDeaths
where continent is not NULL
group by continent

select * from TotalDeathCount



