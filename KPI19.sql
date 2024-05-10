/*
    KPI 19:
    Tasa de los tiempos de retraso totales en el despegue 
    de los vuelos por aerolínea.
*/

SELECT 
    AIRLINES.airline, 
    (
        CAST(SUM(CASE WHEN HECHO_VUELOS.dep_delay > 0 THEN 1 ELSE 0 END) AS DECIMAL(10, 2)) /
        COUNT(HECHO_VUELOS.ID_VUELO)
    ) AS tasa_retraso_despegue
FROM
    HECHO_VUELOS
JOIN AIRLINES ON HECHO_VUELOS.CODE_AIRLINE = AIRLINES.CODE_AIRLINE  
GROUP BY
    AIRLINES.airline;
