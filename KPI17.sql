/*
    KPI 17: LISTO
    Promedio de diferencia de tiempo de vuelo por aerolínea y ciudad.
*/

SELECT  
    AIRLINES.airline, 
    CITIES.name_city,
    YEARS.fl_year, 
    (
        CAST(SUM(HECHO_VUELOS.ELAPSED_TIME - HECHO_VUELOS.crs_elapsed_time) AS DECIMAL(10, 2)) / 
        COUNT(HECHO_VUELOS.ID_VUELO)
    ) AS promedio_diferencia_tiempo_vuelo
FROM HECHO_VUELOS
JOIN AIRLINES ON HECHO_VUELOS.CODE_AIRLINE = AIRLINES.CODE_AIRLINE  
JOIN CITIES ON HECHO_VUELOS.CODE_CITY = CITIES.CODE_CITY
join days on HECHO_VUELOS.id_day = DAYS.id_day
join months on DAYS.id_month  = MONTHS.id_month 
join YEARS on MONTHS.id_year = YEARS.id_year
join state_flights on HECHO_VUELOS.id_state_flights = state_flights.id_state_flights 
where 
	YEARS.ID_YEAR BETWEEN 2019 AND 2023
    and state_flights.id_state_flights = 1
GROUP BY
    AIRLINES.airline,
    CITIES.name_city,
    YEARS.fl_year;
