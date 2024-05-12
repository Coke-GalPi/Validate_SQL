/*
    KPI 11: LISTO
    Ratio de porcentajes de vuelos realizados por ruta y que sufrieron
    cancelaciones por aerolínea entre los años 2019-2023
*/

SELECT 
	airlines.airline,
	routes.route,
    years.fl_year,
    (CAST(SUM(CASE WHEN hecho_vuelos.id_state_flights = 2 THEN 1 ELSE 0 END) AS DECIMAL) / COUNT(hecho_vuelos.id_vuelo)) * 100 AS cancelled_count,
    LAG((CAST(SUM(CASE WHEN hecho_vuelos.id_state_flights = 2 THEN 1 ELSE 0 END) AS DECIMAL)) / COUNT(hecho_vuelos.id_vuelo)) OVER (ORDER BY years.fl_year) * 100 AS cancelled_count_anterior, 
    ((CAST(SUM(CASE WHEN hecho_vuelos.id_state_flights = 2 THEN 1 ELSE 0 END) AS DECIMAL) / COUNT(hecho_vuelos.id_vuelo)) * 100) / 
    	(LAG((CAST(SUM(CASE WHEN hecho_vuelos.id_state_flights = 2 THEN 1 ELSE 0 END) AS DECIMAL)) / COUNT(hecho_vuelos.id_vuelo)) OVER (ORDER BY years.fl_year) * 100) as ratio_cancelled
FROM hecho_vuelos
join airlines on hecho_vuelos.code_airline = airlines.code_airline 
join days ON hecho_vuelos.id_day = days.id_day
JOIN months ON days.id_month = months.id_month
JOIN years ON months.id_year = years.id_year
join routes on hecho_vuelos.code_route = routes.code_route
WHERE 
    years.fl_year BETWEEN 2019 AND 2023
GROUP BY 
    airlines.airline,
	routes.route,
	years.fl_year;