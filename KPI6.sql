/* 
    KPI 6: LISTO
    Ratio de Eficiencia de Operación por Aerolínea y Cancelación
*/


SELECT
    airlines.airline,
    COUNT(hecho_vuelos.id_vuelo) AS total,
    COUNT(CASE WHEN hecho_vuelos.id_state_flights = 2 THEN 1 END) AS cancelados,
    (
        (
            COUNT(CASE WHEN hecho_vuelos.id_state_flights = 1 THEN 1 END) - 
            COUNT(CASE WHEN hecho_vuelos.id_state_flights = 2 THEN 1 END)
        ) / CAST(COUNT(CASE WHEN hecho_vuelos.id_state_flights = 1 THEN 1 END) AS DECIMAL(10,2))
    ) * 100 AS ratio_eficiencia_operacion
FROM hecho_vuelos
JOIN airlines ON hecho_vuelos.code_airline = airlines.code_airline   
GROUP BY airlines.airline;
