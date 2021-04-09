select datepart(year,dt) as Year,country, avg(averagetemperature) as AVG​
from GlobalLandTemperatures_GlobalLandTemperaturesByCountry ​
where Country in ( 'Canada', 'France', 'Germany', 'Italy', 'Japan', 'United States', 'United Kingdom') ​
and AverageTemperature like '%_%' and ​
dt between '1900-01-01' and '2013-09-01'​
group by datepart(year, dt), Country​
order by country,datepart(year, dt)



select datepart(year,dt) as Year, avg(LandAverageTemperature) as AVG ​
from GlobalLandTemperatures_GlobalTemperatures​
where LandAverageTemperature like '%_%' and ​
dt between '1900-01-01' and '2013-09-01' ​
group by datepart(year, dt)​
order by datepart(year, dt)