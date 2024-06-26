/*
    KPI 1: LISTO
    Porcentaje de vuelos retrasados por aerolínea entre los años 2019-2023.
*/

SELECT 
    AIRLINES.airline,
    YEARS.FL_YEAR,
    CAST(SUM(CASE WHEN HECHO_VUELOS.time_delay > 0 THEN HECHO_VUELOS.time_delay ELSE 0 END) AS DECIMAL(10,2)) /
    CAST(count(HECHO_VUELOS.id_vuelo) AS DECIMAL(10,2)) as Promedio_Retrasos
FROM HECHO_VUELOS
JOIN AIRLINES ON HECHO_VUELOS.CODE_AIRLINE = AIRLINES.CODE_AIRLINE
JOIN DAYS ON HECHO_VUELOS.ID_DAY = DAYS.ID_DAY
JOIN MONTHS ON DAYS.ID_MONTH = MONTHS.ID_MONTH
JOIN YEARS ON MONTHS.ID_YEAR = YEARS.ID_YEAR
JOIN type_delays ON HECHO_VUELOS.id_type_delay = TYPE_DELAYS.id_type_delay 
GROUP BY 
    AIRLINES.airline,
    YEARS.FL_YEAR;
