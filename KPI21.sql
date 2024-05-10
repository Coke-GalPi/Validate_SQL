/*
    KPI 19: revisar listo 
    Tiempo promedio de rendimiento en el despegue de los vuelos 
    realizados por aerolínea entre los años 2019-2023
*/

select 
    airlines.airline,
    avg(hecho_vuelos.dep_delay) as tiempo_despegue
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
where
    years.fl_year between 2019 and 2023
group by
    airlines.airline