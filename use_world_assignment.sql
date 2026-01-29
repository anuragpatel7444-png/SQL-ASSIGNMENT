use world;

-- ====================================================
-- PART 1: SETUP MISSING TABLES & DATA
-- ====================================================

-- 1. Setup 'city' table (Required for Q1, Q7, Q8)
DROP TABLE IF EXISTS city;
CREATE TABLE city (
    ID INT, 
    Name CHAR(35), 
    CountryCode CHAR(3), 
    District CHAR(20), 
    Population INT
);

INSERT INTO city VALUES 
(1,'Kabul','AFG','Kabol',1780000),
(2,'Qandahar','AFG','Qandahar',237500),
(3,'Mumbai (Bombay)','IND','Maharashtra',10500000),
(4,'Delhi','IND','Delhi',7206704),
(5,'New York','USA','New York',8008278),
(6,'Los Angeles','USA','California',3694820),
(7,'Shanghai','CHN','Shanghai',9696300),
(8,'Sao Paulo','BRA','Sao Paulo',9968485),
(9,'London','GBR','England',7285000),
(10,'Berlin','DEU','Berliini',3386667);

-- 2. Setup 'countrylanguage' table (Required for Q5)
DROP TABLE IF EXISTS countrylanguage;
CREATE TABLE countrylanguage (
    CountryCode CHAR(3), 
    Language CHAR(30), 
    IsOfficial ENUM('T','F'), 
    Percentage FLOAT
);

INSERT INTO countrylanguage VALUES 
('IND','Hindi','T',39.9),
('IND','English','F',10.0),
('USA','English','T',86.2),
('CHN','Chinese','T',92.0),
('BRA','Portuguese','T',97.5),
('RUS','Russian','T',86.6),
('JPN','Japanese','T',99.1),
('DEU','German','T',91.3),
('GBR','English','T',97.3),
('FRA','French','T',93.6);


-- ====================================================
-- PART 2: ASSIGNMENT SOLUTIONS (Questions 1 to 10)
-- ====================================================

-- Question 1: Count how many cities are there in each country?
SELECT CountryCode, COUNT(*) AS TotalCities
FROM city
GROUP BY CountryCode;

-- Question 2: Display all continents having more than 30 countries.
SELECT Continent, COUNT(*) AS TotalCountries
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;

-- Question 3: List regions whose total population exceeds 200 million.
SELECT Region, SUM(Population) AS TotalPopulation
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000;

-- Question 4: Find the top 5 continents by average GNP per country.
SELECT Continent, AVG(GNP) AS AvgGNP
FROM country
GROUP BY Continent
ORDER BY AvgGNP DESC
LIMIT 5;

-- Question 5: Find the total number of official languages spoken in each continent.
SELECT c.Continent, COUNT(cl.Language) AS OfficialLanguages
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent;

-- Question 6: Find the maximum and minimum GNP for each continent.
SELECT Continent, MAX(GNP) AS MaxGNP, MIN(GNP) AS MinGNP
FROM country
GROUP BY Continent;

-- Question 7: Find the country with the highest average city population.
SELECT c.Name AS CountryName, AVG(ci.Population) AS AvgCityPopulation
FROM country c
JOIN city ci ON c.Code = ci.CountryCode
GROUP BY c.Name
ORDER BY AvgCityPopulation DESC
LIMIT 1;

-- Question 8: List continents where the average city population is greater than 200,000.
SELECT c.Continent, AVG(ci.Population) AS AvgCityPop
FROM country c
JOIN city ci ON c.Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000;

-- Question 9: Find the total population and average life expectancy for each continent.
SELECT Continent, SUM(Population) AS TotalPop, AVG(LifeExpectancy) AS AvgLifeExp
FROM country
GROUP BY Continent
ORDER BY AvgLifeExp DESC;

-- Question 10: Top 3 continents with highest life expectancy (population > 200 Million).
SELECT Continent, AVG(LifeExpectancy) AS AvgLifeExp, SUM(Population) AS TotalPop
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AvgLifeExp DESC
LIMIT 3;

select * from country;

