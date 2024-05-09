/*
    KPI 2: revisar por x2
    Tasa de decrecimiento de los vuelos completados con éxito 
    por aeorlínea entre los años 2019-2023.
*/

select 
    airlines.airline,
    (count(case when state_flights.type_state_flights = 'completed flight' then 1 else null end) - count(case when state_flights.type_state_flights = 'completed flight' then 1 else null end)) / count(case when state_flights.type_state_flights = 'completed flight' then 1 else null end) * 100 as tasa_decrecimiento_vuelos_completados    
from
    hecho_vuelos
join
    airlines on hecho_vuelos.code_airline = airlines.code_airline
join
    days on hecho_vuelos.id_day = days.id_day   
join
    months on days.id_month = months.id_month
join
    years on months.id_year = years.id_year
join
    state_flights on hecho_vuelos.id_state_flights = state_flights.id_state_flights
where
    years.fl_year between 2019 and 2023
group by
    airlines.airline;