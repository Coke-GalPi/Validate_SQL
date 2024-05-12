/*
    KPI 20: 
    Tasa de crecimiento de los tiempos de despegue de los vuelos puntuales 
    en las ciudades de destino por aerolínea. 
*/

SELECT
    airlines.airline,
    states.name_state,
    years.fl_year,
    SUM(CASE WHEN hecho_vuelos.time_delay = 0 THEN hecho_vuelos.dep_delay ELSE 0 END) AS sum_depd,
    LAG(SUM(CASE WHEN hecho_vuelos.time_delay = 0 THEN hecho_vuelos.dep_delay ELSE 0 END)) OVER (PARTITION BY airlines.airline, states.name_state ORDER BY years.fl_year) AS sum_depd_anterior,
    CASE
        WHEN LAG(SUM(CASE WHEN hecho_vuelos.time_delay = 0 THEN hecho_vuelos.dep_delay ELSE 0 END)) OVER (PARTITION BY airlines.airline, states.name_state ORDER BY years.fl_year) = 0 THEN NULL
        ELSE
            (SUM(CASE WHEN hecho_vuelos.time_delay = 0 THEN hecho_vuelos.dep_delay ELSE 0 END) -
            LAG(SUM(CASE WHEN hecho_vuelos.time_delay = 0 THEN hecho_vuelos.dep_delay ELSE 0 END)) OVER (PARTITION BY airlines.airline, states.name_state ORDER BY years.fl_year))
            / NULLIF(
                CAST(LAG(SUM(CASE WHEN hecho_vuelos.time_delay = 0 THEN hecho_vuelos.dep_delay ELSE 0 END)) OVER (PARTITION BY airlines.airline, states.name_state ORDER BY years.fl_year) AS DECIMAL(10,2)),
                0
            )
    END AS tasa_crecimiento
FROM hecho_vuelos
JOIN airlines ON hecho_vuelos.code_airline = airlines.code_airline
JOIN days ON hecho_vuelos.id_day = days.id_day 
JOIN months ON days.id_month = months.id_month 
JOIN years ON months.id_year = years.id_year
JOIN cities ON hecho_vuelos.code_city = cities.code_city 
JOIN states ON cities.code_state = states.code_state 
WHERE 
    years.fl_year BETWEEN 2019 AND 2023
GROUP BY
    airlines.airline,
    states.name_state,
    years.fl_year;
