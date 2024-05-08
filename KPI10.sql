/*
    KPI 10:
    Porcentaje de la varianza de los vuelos retrasados por tipo de retraso y aerolínea.
*/

select 
    airlines.airline, 
    type_delays.type_delay, 
    var_samp(hecho_vuelos.time_delay) as Varianza_Retrasos
from
    hecho_vuelos
join
    airlines on hecho_vuelos.code_airline = airlines.code_airline
join
    type_delays on hecho_vuelos.id_type_delay = type_delays.id_type_delay
where
    hecho_vuelos.time_delay > 0
group by
    airlines.airline, 
    type_delays.type_delay;