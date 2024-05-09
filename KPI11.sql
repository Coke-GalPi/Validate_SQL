/*
    KPI 11: listo
    Tasa de crecimiento de tiempos promedios de tipo de retraso de los 
    vuelos realizados por cada aerolínea entre los años 2019-2023.
*/

select 
    airlines.airline,
    months.fl_season,
    type_delays.type_delay,
    avg(hecho_vuelos.time_delay) as tiempo_promedio_retraso
from
    hecho_vuelos
join
    airlines on hecho_vuelos.code_airline = airlines.code_airline
join
    type_delays on hecho_vuelos.id_type_delay = type_delays.id_type_delay
join
    days on hecho_vuelos.id_day = days.id_day
join
    months on days.id_month = months.id_month
join
    years on months.id_year = years.id_year
where
    (years.fl_year between 2019 and 2023)  and
    hecho_vuelos.time_delay > 0
group by
    airlines.airline,
    months.fl_season,
    type_delays.type_delay;