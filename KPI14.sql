/*
    KPI 14: LISTO
    Ratio de Tiempo ocupado entre Despegue y Aterrizaje por 
    aerolínea y Estado entre los años 2019-2023.
*/

select  
    a.airline,
    y.fl_year,
    s.name_state,
    case
        when sum(hv.arr_delay + hv.taxi_on) = 0 then null
        else (
            sum(hv.dep_delay + hv.taxi_out) / 
            cast(sum(hv.arr_delay + hv.taxi_on) as decimal(14,2))
        )
    end as ratio_despegue_aterrizaje 
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

