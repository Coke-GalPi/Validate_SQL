/*
    KPI 12: LISTO
    Promedio de vuelos por tipo de retraso entre los años 2019-2023.
*/

SELECT 
	routes.route,
    type_delays.type_delay,
    SUM(case when hecho_vuelos.time_delay > 0 then 1 else 0 end) as SUM_TD,
    CAST((SELECT COUNT(id_vuelo) FROM hecho_vuelos WHERE id_state_flights = 1) AS decimal(10,2)) AS COUNT_TD,
    (SUM(case when hecho_vuelos.time_delay > 0 then 1 else 0 end) /
    CAST((SELECT COUNT(id_vuelo) FROM hecho_vuelos WHERE id_state_flights = 1) AS decimal(10,2))) * 100 AS porcentaje
FROM
    hecho_vuelos
JOIN days ON hecho_vuelos.id_day = days.id_day
JOIN months ON days.id_month = months.id_month
JOIN years ON months.id_year = years.id_year
JOIN type_delays ON hecho_vuelos.id_type_delay = type_delays.id_type_delay
join routes on hecho_vuelos.code_route = routes.code_route 
WHERE
    years.fl_year BETWEEN 2019 AND 2023
    AND type_delays.id_type_delay > 1
GROUP BY
	routes.route,
	type_delays.type_delay;