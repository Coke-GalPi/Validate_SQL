/*
    KPI 4: LISTO
    Ratio de vuelos entre el promedio de vuelos retrasados y el promedio 
    de vuelos puntuales por aerolínea entre los años 2019-2023.
*/

SELECT
    airlines.airline,
    years.fl_year,
    SUM(CASE WHEN hecho_vuelos.time_delay > 0 THEN 1 ELSE 0 END) AS parte_1,
    SUM(CASE WHEN hecho_vuelos.time_delay = 0 THEN 1 ELSE 0 END) AS parte_2,
    CAST(COUNT(hecho_vuelos.id_vuelo) AS DECIMAL(10,2)) AS partes_3,
    (
        SUM(CASE WHEN hecho_vuelos.time_delay > 0 THEN 1 ELSE 0 END) /
        CAST(COUNT(hecho_vuelos.id_vuelo) AS DECIMAL(10,2))
    ) /
    (
        SUM(CASE WHEN hecho_vuelos.time_delay = 0 THEN 1 ELSE 0 END) /
        CAST(COUNT(hecho_vuelos.id_vuelo) AS DECIMAL(10,2))
    ) AS ratio
FROM
    hecho_vuelos
JOIN airlines ON hecho_vuelos.code_airline = airlines.code_airline
JOIN days ON hecho_vuelos.id_day = days.id_day
JOIN months ON days.id_month = months.id_month
JOIN years ON months.id_year = years.id_year
WHERE
    years.fl_year BETWEEN 2019 AND 2023
GROUP BY
    airlines.airline,
    years.fl_year;