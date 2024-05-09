/*
    KPI 4: lISTO
    Ratio de vuelos entre el promedio de vuelos retrasados y el promedio 
    de vuelos puntuales por aerolínea entre los años 2019-2023.
*/

select
    airlines.airline, years.fl_year
    ((
        avg(case when hecho_vuelos.time_delay > 0 then 1 else 0 end) /
        avg(case when hecho_vuelos.arr_delay = 0 then 1 else 0 end)
	) / (
		avg(case when hecho_vuelos.time_delay > 0 then 1 else 0 end) /
        avg(case when hecho_vuelos.arr_time = 0 then 1 else 0 end)
	) 
	) as ratio
from
    hecho_vuelos
join airlines on hecho_vuelos.code_airline  = airlines.code_airline
join days on hecho_vuelos.id_day = days.id_day
join months on days.id_month = months.id_month
join years on months.id_year  = years.id_year
where
    years.fl_year between 2019 and 2023
group by
    airlines.airline, 
    years.fl_year;