/*
    KPI 16: LISTO
    Índice de Eficiencia de Tiempo de Vuelo por Estado y Aerolínea (IETVEA)
*/

SELECT 
    AIRLINES.airline,
    STATES.name_state, 
    YEARS.fl_year,
    (
        CAST(SUM(HECHO_VUELOS.ELAPSED_TIME) AS DECIMAL(10, 2)) /
        SUM(HECHO_VUELOS.crs_elapsed_time)
    ) AS ietvea
FROM
    HECHO_VUELOS
JOIN AIRLINES ON HECHO_VUELOS.CODE_AIRLINE = AIRLINES.CODE_AIRLINE
JOIN CITIES ON HECHO_VUELOS.CODE_CITY = CITIES.CODE_CITY
JOIN STATES ON CITIES.CODE_STATE = STATES.CODE_STATE
JOIN DAYS ON HECHO_VUELOS.ID_DAY = DAYS.ID_DAY
JOIN MONTHS ON DAYS.ID_MONTH = MONTHS.ID_MONTH
JOIN YEARS ON MONTHS.ID_YEAR = YEARS.ID_YEAR
join state_flights on HECHO_VUELOS.id_state_flights = state_flights.id_state_flights 
WHERE 
    YEARS.ID_YEAR BETWEEN 2019 AND 2023
    and state_flights.id_state_flights = 1
GROUP BY
    STATES.name_state, 
    AIRLINES.airline,
    YEARS.fl_year;