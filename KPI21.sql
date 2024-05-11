/*
    KPI 19: 
    Tasa de los tiempos de retraso totales en el despegue de 
    los vuelos por aerolínea.
*/

select 
    airlines.airline, 
    (
        CAST(SUM(CASE WHEN hecho_vuelos.dep_delay > 0 THEN 1 ELSE 0 END) AS DECIMAL(10, 2)) /
        COUNT(hecho_vuelos.id_vuelo)
    ) * 100 AS tasa_retraso_despegue
from
    hecho_vuelos
join airlines on hecho_vuelos.code_airline = airlines.code_airline
group by
    airlines.airline;