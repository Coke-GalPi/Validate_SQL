/*
    KPI 8: LISTO
    Índice de Retraso Promedio por Causa Climática y 
    Estación del Año (IRPCE):
*/

SELECT 
    YEARS.fl_year,
    TYPE_DELAYS.type_delay,
    SUM(CASE WHEN HECHO_VUELOS.id_type_delay = 6 THEN time_delay ELSE 0 END) / CAST(COUNT(CASE WHEN HECHO_VUELOS.id_type_delay = 6 THEN 1 ELSE 0 END) AS DECIMAL(10,2)) as IRPCE
FROM  hecho_vuelos
JOIN type_delays ON HECHO_VUELOS.id_type_delay = TYPE_DELAYS.id_type_delay
JOIN days ON HECHO_VUELOS.id_day = DAYS.id_day
JOIN months ON DAYS.id_month = months.id_month 
JOIN years ON MONTHS.id_year = YEARS.id_year
WHERE 
    (years.fl_year BETWEEN 2019 AND 2023) and 
    type_delays.type_delay = 'delay due weather'
GROUP BY 
    YEARS.fl_year,
    TYPE_DELAYS.type_delay;
