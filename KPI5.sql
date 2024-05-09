/*
    KPI 5: Listo
    Tasa de crecimiento de vuelos con retrasos por aerolínea entre los años 2019-2023.
*/

select 
    years.fl_year,
    sum(hecho_vuelos.time_delay) as SUM_time_delay,
    
    lag(sum(hecho_vuelos.time_delay)) over (order by years.fl_year) as Sumtimedelaypastyear,
    
    cast((sum(hecho_vuelos.time_delay) - lag(sum(hecho_vuelos.time_delay)) over (order by years.fl_year))
        / lag(sum(hecho_vuelos.time_delay)) over (order by years.fl_year) as decimal(10, 2)) as growth_rate1

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

    /*
   *(years.fl_year between 2019 and 2023) and
   *hecho_vuelos.code_airline = 'WN' 
   */

group by 
    years.fl_year;