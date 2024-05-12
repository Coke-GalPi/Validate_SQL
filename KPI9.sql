/*
    KPI 9: LISTO
    Índice de Seguridad por Ruta (ISR) según Estación del Año entre los años 2019-2023.
*/

SELECT
    routes.route,
    months.fl_season,
    CASE 
        WHEN SUM(CASE WHEN hecho_vuelos.id_state_flights = 1 THEN hecho_vuelos.distance ELSE 0 END) = 0 
        THEN 0
        ELSE
            (
                (
                    SUM(CASE WHEN hecho_vuelos.id_state_flights = 2 THEN 1 ELSE 0 END) +
                    SUM(CASE WHEN hecho_vuelos.id_state_flights = 3 THEN 1 ELSE 0 END) +
                    SUM(CASE WHEN hecho_vuelos.time_delay > 0 THEN 1 ELSE 0 END)
                ) /
                (
                    CAST(SUM(CASE WHEN hecho_vuelos.id_state_flights = 1 THEN hecho_vuelos.distance ELSE 0 END) AS DECIMAL(14,2))
                ) * 100
            )
    END AS ISR
FROM hecho_vuelos
JOIN routes ON hecho_vuelos.code_route = routes.code_route 
JOIN days ON hecho_vuelos.id_day = days.id_day 
JOIN months ON days.id_month = months.id_month 
JOIN years ON months.id_year = years.id_year
WHERE 
    years.fl_year BETWEEN 2019 AND 2023
GROUP BY
    routes.route,
    months.fl_season;