SELECT * FROM Portfolio..CovidDeaths
ORDER BY weekly_icu_admissions DESC;

SELECT * FROM Portfolio..CovidVaccinations;


-- 1. Total death in comparison to total cases in Poland
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases*100) AS Death_Percentage
FROM Portfolio..CovidDeaths
WHERE location like '%Poland%'
ORDER BY 1,2 ASC;

-- 2. Countries with maximum total cases
SELECT Location, Max(total_cases) AS Max_cases
FROM Portfolio..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Max_cases DESC;

-- 3. Countries with maximum total cases in comparison to population
SELECT Location, MAX(total_cases) AS Max_cases, population, Max(total_cases/population*100) AS Cases_to_population
FROM Portfolio..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY population, location
ORDER BY Cases_to_population DESC;

-- 4. Countries with maximum total death
SELECT Location, Max(total_deaths) AS Max_death
FROM Portfolio..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Max_death DESC;

-- 5. Countries with maximum total death in comparison to population
SELECT Location, Max(total_deaths) AS Max_death, population, Max(total_deaths/population*100) AS Death_to_population
FROM Portfolio..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY population, location
ORDER BY Death_to_population DESC;



-- 6. Total death in comparison to total cases in the World
SELECT date, SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Death, SUM(new_deaths)/SUM(new_cases)*100 AS Death_percentage
FROM Portfolio..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2 ASC;

--7. Total death to vaccinations
SELECT d.continent, d.location, d.date, d.total_deaths, v.new_vaccinations, SUM(CONVERT(int,v.new_vaccinations)) 
OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS people_vaccinated
FROM  Portfolio..CovidDeaths d INNER JOIN Portfolio..CovidVaccinations v
ON d.iso_code = v.iso_code and d.date = v.date
WHERE d.continent IS NOT NULL
ORDER BY 2,3 ASC;






