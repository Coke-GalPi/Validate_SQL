/*
    KPI 19: LISTO
    Tiempo promedio de rendimiento en el despegue de los vuelos 
	realizados por aerolínea entre los años 2019-2023.
*/

select  
	a.airline,
	y.fl_year,
	s.name_state,
	sum(hv.dep_delay) as sum_dep_delay,
	count(hv.id_vuelo) as count_id_vuelo,
	(
		sum(hv.dep_delay) / cast(count(hv.id_vuelo) as decimal(10,2))
	) as promedio_rendimiento_despegue 
from hecho_vuelos hv
join days d on hv.id_day = d.id_day
join months m on d.id_month = m.id_month 
join years y on m.id_year = y.id_year
join cities c on hv.code_city = c.code_city
join states s on c.code_state = s.code_state
join airlines a on hv.code_airline = a.code_airline 
join type_delays td on hv.id_type_delay = td.id_type_delay
group by
    a.airline,
    y.fl_year,
    s.name_state;