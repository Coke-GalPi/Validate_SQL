/* 
    KPI 7: listo
    Tasa de crecimiento de vuelos por estación del año entre los años 2019-2023.
*/

SELECT
    years.fl_year,
    months.fl_season,
    COUNT(hecho_vuelos.id_vuelo) AS total_vuelos,
    (
        CAST((COUNT(hecho_vuelos.id_vuelo) - LAG(COUNT(hecho_vuelos.id_vuelo), 1) OVER (PARTITION BY months.fl_season ORDER BY years.fl_year)) AS DECIMAL(10, 2)) /
        NULLIF(LAG(COUNT(hecho_vuelos.id_vuelo), 1) OVER (PARTITION BY months.fl_season ORDER BY years.fl_year), 0)
    )  AS tasa_crecimiento
FROM
    hecho_vuelos
JOIN days ON hecho_vuelos.id_day = days.id_day
JOIN months ON days.id_month = months.id_month
JOIN years ON months.id_year = years.id_year
WHERE
    years.fl_year BETWEEN 2019 AND 2023
GROUP BY
    years.fl_year,
    months.fl_season;
