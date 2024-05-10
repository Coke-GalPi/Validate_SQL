/*
    KPI 15:
    Ratio de Tiempo de Vuelo en el Aire-Tiempo en Tierra por aerolínea hacia 
    los distintos Estados de destino entre 2019-2023.
*/

SELECT
    AIRLINES.AIRLINE,
    years.fl_year,
    (SUM(hecho_vuelos.air_time)-
    SUM(hecho_vuelos.dep_time + hecho_vuelos.taxi_on + hecho_vuelos.taxi_out + hecho_vuelos.arr_time)) AS tiempo_total
FROM 
    hecho_vuelos
JOIN AIRLINES ON HECHO_VUELOS.CODE_AIRLINE = AIRLINES.CODE_AIRLINE
join cities on HECHO_VUELOS.code_city = CITIES.code_city
join STATES on CITIES.code_state = STATES.code_state
JOIN  DAYS ON HECHO_VUELOS.ID_DAY = DAYS.ID_DAY
JOIN  MONTHS ON DAYS.ID_MONTH = MONTHS.ID_MONTH
JOIN  YEARS ON MONTHS.ID_YEAR = YEARS.ID_YEAR
WHERE
    (YEARS.ID_YEAR BETWEEN 2019 AND 2023) and
    hecho_vuelos.id_state_flights = 1 /*and 
    states.name_state = 'Florida'*/
GROUP BY
    AIRLINES.AIRLINE,
    years.fl_year;