/*
    KPI 3: listo
    Tiempo promedio de despegues por aerolínea entre los años 2019-2023.
*/

select
    airlines.airline,
    years.fl_year,
    avg(hecho_vuelos.dep_delay) as avg_dep_delay
from
    hecho_vuelos
join airlines on hecho_vuelos.code_airline  = airlines.code_airline 
join days on hecho_vuelos.id_day = days.id_day
join months on days.id_month = months.id_month 
join years on months.id_year  = years.id_year
where
    hecho_vuelos.dep_delay > 0
    and years.fl_year between 2019 and 2023
group by
    airlines.airline,
    years.fl_year;