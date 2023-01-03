SELECT * FROM CovidPortfollioProject.coviddeath;

-- Select data to be used
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM CovidPortfollioProject.coviddeath
ORDER BY 3,4;

-- Total Cases vs Total Deaths
-- Likelyhood of dying if covid contracted in the United States
SELECT Location, date, total_cases,  total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM CovidPortfollioProject.coviddeath
WHERE location like '%State%'
ORDER BY 1,2;

-- Looking at Total Cases vs Population
-- Shows what percentage of the United States population got Covid

SELECT Location, date, total_cases, population, (total_cases/population)*100 AS PercentofPopulationInfected
FROM CovidPortfollioProject.coviddeath
WHERE location like '%State%'
ORDER BY 1,2;


-- Looking at countries with highest infection rate compared to population

SELECT continent, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentofPopulationInfected
FROM CovidPortfollioProject.coviddeath
-- WHERE location like '%States%
GROUP BY continent
ORDER BY PercentofPopulationInfected DESC;

-- Breakdown by Location
SELECT Location, MAX(CAST(total_deaths AS float)) AS TotalDeathCount
FROM CovidPortfollioProject.coviddeath
-- WHERE location like %States%
WHERE continent is not null
GROUP BY Location
ORDER BY TotalDeathCount DESC;

-- Breakdown by continent
-- Showing continents with highest death count per population-
SELECT continent, MAX(CAST(total_deaths AS float)) AS TotalDeathCount
FROM CovidPortfollioProject.coviddeath
-- WHERE location like %States%
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC;


-- Global numbers
SELECT  SUM(new_cases) AS total_cases, SUM(CAST(new_deaths as float)) AS total_deaths, SUM(CAST(new_deaths as float))/SUM(new_cases)*100 AS DeathPercentage -- total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidPortfollioProject.coviddeath
-- WHERE location like '%State%'
WHERE continent is not null
-- GROUP BY date
ORDER BY 1,2;

-- USE CTE 
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
-- Looking at Total Population vs Vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS float)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
FROM CovidPortfollioProject.coviddeath dea
JOIN CovidPortfollioProject.covidvaccination vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is not null
-- ORDER BY 2, 3
)
SELECT*, (RollingPeopleVaccinated/population)*100 
FROM PopvsVac;


CREATE VIEW PercebtPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS float)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
FROM CovidPortfollioProject.coviddeath dea
JOIN CovidPortfollioProject.covidvaccination vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent is not null;

Select*
From PercebtPopulationVaccinated




