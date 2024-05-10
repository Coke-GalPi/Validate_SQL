/*
    KPI 2: revisar por x2
    Tasa de decrecimiento de los vuelos completados con éxito 
    por aerolínea entre los años 2019-2023.
*/

select 
    airlines.airline,
    cast((sum(hecho_vuelos.id_state_flights) - lag(sum(hecho_vuelos.id_state_flights)) over (order by )
    / lag(sum(hecho_vuelos.id_state_flights)) over (order by years.fl_year) as decimal(10, 2)) as growth_rate1
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