/*
    KPI 14: 
    Porcentajes de vuelos por tipo de retraso entre los años 2019-2023.
*/

SELECT 
    years.fl_year,
    type_delays.type_delay,
    COUNT(*) AS total_vuelos,
    SUM(CASE WHEN hecho_vuelos.time_delay > 0 THEN 1 ELSE 0 END) AS sum_time_delay, 
    (SUM(CASE WHEN hecho_vuelos.time_delay > 0 THEN 1 ELSE 0 END) / COUNT(*) * 100) AS porcentaje
FROM
    hecho_vuelos
JOIN days ON hecho_vuelos.id_day = days.id_day
JOIN months ON days.id_month = months.id_month
JOIN years ON months.id_year = years.id_year
JOIN type_delays ON hecho_vuelos.id_type_delay = type_delays.id_type_delay
WHERE
    years.fl_year BETWEEN 2019 AND 2023
GROUP BY
    years.fl_year,
    type_delays.type_delay;