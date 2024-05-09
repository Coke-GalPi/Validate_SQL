/* 
    KPI 6: Listo
    Ratio de Eficiencia de Operación por Aerolínea y Cancelación
*/

select
    airlines.airline,
    count(hecho_vuelos.id_vuelo) as total,
    count(case when hecho_vuelos.id_state_flights = 2 then 1 end) as cancelados,
    (
        (count(hecho_vuelos.id_vuelo) - count(case when hecho_vuelos.id_state_flights = 2 then 1 end))
        / 
        cast(count(hecho_vuelos.id_vuelo) as decimal(10,2))
    ) * 100 as ratio_eficiencia_operacion
from hecho_vuelos
join airlines on hecho_vuelos.code_airline = airlines.code_airline   
group by airlines.airline;
