/*
    KPI 10: LISTO
    Tasa de crecimiento de tiempos promedios de tipo de retraso 
    de los vuelos realizados por cada aerolínea entre los años 
    2019-2023.
*/

SELECT 
    airlines.airline,
    years.fl_year,
    TYPE_DELAYS.type_delay,
    (
        ((
            SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) / 
            CAST(COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
        ) - 
        LAG(
            SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) / 
            CAST(COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
        ) OVER (PARTITION BY airlines.airline ORDER BY years.fl_year)) /
        LAG(
            SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) / 
            CAST(COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
        ) OVER (PARTITION BY airlines.airline ORDER BY years.fl_year)
    ) AS Tasa_crecimiento
FROM hecho_vuelos
JOIN airlines ON hecho_vuelos.code_airline = airlines.code_airline
JOIN type_delays ON hecho_vuelos.id_type_delay = type_delays.id_type_delay
JOIN days ON hecho_vuelos.id_day = days.id_day
JOIN months ON days.id_month = months.id_month
JOIN years ON months.id_year = years.id_year
WHERE
    years.fl_year BETWEEN 2019 AND 2023
    AND hecho_vuelos.time_delay > 0
GROUP BY
    airlines.airline,
    years.fl_year,
    TYPE_DELAYS.type_delay;



(CASO DE ERROR)
SELECT 
    airlines.airline,
    years.fl_year,
    SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) AS SUM_TIME_DELAY,
    COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS COUNT_TIME_DELAY,
    (
        SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) / 
        CAST(COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
    ) AS AVERAGE_DELAY_0,
    (
        (
            SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) / 
            CAST(COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
        ) - 
        LAG(
            SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) / 
            CAST(COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
        ) OVER (PARTITION BY airlines.airline ORDER BY years.fl_year)
    ) AS AVERAGE_DELAY_ANTERIOR,
    (
        ((
            SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) / 
            CAST(COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
        ) - 
        LAG(
            SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) / 
            CAST(COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
        ) OVER (PARTITION BY airlines.airline ORDER BY years.fl_year)) /
        LAG(
            SUM(CASE WHEN hecho_vuelos.time_delay >= 1 THEN hecho_vuelos.dep_delay ELSE 0 END) / 
            CAST(COUNT(CASE WHEN hecho_vuelos.time_delay >= 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
        ) OVER (PARTITION BY airlines.airline ORDER BY years.fl_year)
    ) AS AVERAGE_DELAY
FROM hecho_vuelos
JOIN airlines ON hecho_vuelos.code_airline = airlines.code_airline
JOIN type_delays ON hecho_vuelos.id_type_delay = type_delays.id_type_delay
JOIN days ON hecho_vuelos.id_day = days.id_day
JOIN months ON days.id_month = months.id_month
JOIN years ON months.id_year = years.id_year
WHERE
    years.fl_year BETWEEN 2019 AND 2023
    AND hecho_vuelos.time_delay > 0
GROUP BY
    airlines.airline,
    years.fl_year;
