/*
    KPI 18: LISTO
    Tiempo promedio de retraso por vuelos que sufrieron demoras en 
    el despegue según ciudad.
*/

select 
    a.airline,
    c.name_city,
    td.type_delay,
    y.fl_year,
    case
        when sum(case when hv.dep_delay >= 15 then 1 else 0 end) - sum(case when hv.id_state_flights = 3 then 1 else 0 end) = 0 then null
        else (
            sum(case when hv.time_delay > 0 then hv.time_delay else 0 end) /
            cast(
                sum(case when hv.dep_delay >= 15 then 1 else 0 end) - 
                sum(case when hv.id_state_flights = 3 then 1 else 0 end)
            as decimal(10,2))
        )
    end as tiempo_promedio_retraso 
from hecho_vuelos hv
join days d on hv.id_day = d.id_day
join months m on d.id_month = m.id_month 
join years y on m.id_year = y.id_year
join cities c on hv.code_city = c.code_city
join states s on c.code_state = s.code_state
join airlines a on hv.code_airline = a.code_airline 
join state_flights sf on hv.id_state_flights = sf.id_state_flights 
join type_delays td on hv.id_type_delay = td.id_type_delay
where 
    y.fl_year between 2019 and 2023
group by 
    a.airline,
    c.name_city,
    td.type_delay,
    y.fl_year;
