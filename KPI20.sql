/*
    KPI 20: revisar
    Tiempos promedios de los vuelos con retraso en el aterrizaje 
    por Estado de destino y por aerolínea entre los años 2019-2023.

    Tiempos promedios de los vuelos con retraso en el aterrizaje 
    por Estado de destino y por aerolínea entre los años 2019-2023.
*/

SELECT 
    STATES.state, 
    AIRLINES.airline, 
    AVG(HECHO_VUELOS.arr_delay) as Promedio_Retrasos 
FROM
    HECHO_VUELOS    
JOIN
    AIRLINES ON HECHO_VUELOS.CODE_AIRLINE = AIRLINES.CODE_AIRLINE
JOIN
    STATES ON HECHO_VUELOS.CODE_STATE_DEST = STATES.CODE_STATE
JOIN    
    DAYS ON HECHO_VUELOS.ID_DAY = DAYS.ID_DAY
JOIN    
    MONTHS ON DAYS.ID_MONTH = MONTHS.ID_MONTH
JOIN    
    YEARS ON MONTHS.ID_YEAR = YEARS.ID_YEAR
WHERE 
    YEARS.ID_YEAR BETWEEN 2019 AND 2023