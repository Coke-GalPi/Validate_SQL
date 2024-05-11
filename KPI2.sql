/*
    KPI 2: BORRAR
    Tasa de crecimiento de los vuelos completados con éxito 
    por aerolínea entre los años 2019-2023.
*/

select 
    airlines.airline,
    (
        (COUNT(hecho_vuelos.id_state_flights = 1) - count(hecho_vuelos.id_state_flights = 1 anño anterior)) /  
        count(hecho_vuelos.id_state_flights = 1 anño anterior)
    ) as growth_rate1
from hecho_vuelos

join airlines on hecho_vuelos.code_airline = airlines.code_airline
join days on hecho_vuelos.id_day = days.id_day   
join months on days.id_month = months.id_month
join years on months.id_year = years.id_year
join state_flights on hecho_vuelos.id_state_flights = state_flights.id_state_flights

where
    years.fl_year between 2019 and 2023
group by
    airlines.airline;