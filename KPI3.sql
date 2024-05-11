/*
    KPI 3: LISTO
    Tiempo promedio de despegues por aerolínea entre los años 2019-2023.
*/

SELECT
    airlines.airline,
    years.fl_year,
    SUM(CASE WHEN HECHO_VUELOS.time_delay >= 1 THEN HECHO_VUELOS.dep_delay ELSE 0 END) / cast(SUM(CASE WHEN HECHO_VUELOS.time_delay >= 1 THEN 1 ELSE 0 END) as DECIMAL(10,2)) as Promedio_Retrasos
FROM
    hecho_vuelos
JOIN airlines ON hecho_vuelos.code_airline = airlines.code_airline 
JOIN days ON hecho_vuelos.id_day = days.id_day
JOIN months ON days.id_month = months.id_month 
JOIN years ON months.id_year = years.id_year
WHERE
    (years.fl_year BETWEEN 2019 AND 2023)
GROUP BY
    airlines.airline,
    years.fl_year;