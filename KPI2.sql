/*
    KPI 2: LISTO
    Índice de Disrupción Operativa en los Vuelos Realizados 
    entre los años 2019-2023.
*/

select
	airlines.airline,
	sum(case when hecho_vuelos.id_state_flights = 2 then 1 else 0 end) as sum_cancelled,
	sum(case when hecho_vuelos.id_state_flights = 3 then 1 else 0 end) as sum_deverted,
	sum(case when hecho_vuelos.time_delay > 0 then 1 else 0 end) as sum_time_delay,
	sum(case when hecho_vuelos.id_state_flights = 1 then 1 else 0 end) as sum_completed,
	(
        SUM(CASE WHEN hecho_vuelos.id_state_flights = 2 THEN 1 ELSE 0 END) +
        SUM(CASE WHEN hecho_vuelos.id_state_flights = 3 THEN 1 ELSE 0 END) +
        SUM(CASE WHEN hecho_vuelos.time_delay > 0 THEN 1 ELSE 0 END)
    ) /
    (
        CAST(SUM(CASE WHEN hecho_vuelos.id_state_flights = 1 THEN 1 ELSE 0 END) AS DECIMAL(10,2))
    )AS IDOVR
from hecho_vuelos
join airlines on hecho_vuelos.code_airline = airlines.code_airline
join days on hecho_vuelos.id_day = days.id_day 
join months on days.id_month = months.id_month 
join years on months.id_year = years.id_year
where 
	years.fl_year BETWEEN 2019 AND 2023
group by
	airlines.airline;