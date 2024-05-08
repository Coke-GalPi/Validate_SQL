/*
    KPI 8: Por revisar funciones
    Ratio de la tasa de crecimiento de vuelos que sufrieron tipos de 
    retraso por estación del año.
*/

select 
    months.fl_season,
    type_delays.type_delay,
    case 
        when count(case when hecho_vuelos.time_delay = type_delays.time_delay then 1 end) = 0 then 0 
        else 
            (count(case when hecho_vuelos.time_delay = type_delays.time_delay then 1 end) -
            count(case when hecho_vuelos.time_delay = type_delays.time_delay and hecho_vuelos.time_delay = 0 then 1 end)) / 
            nullif(count(case when hecho_vuelos.time_delay = type_delays.time_delay and hecho_vuelos.time_delay = 0 then 1 end), 0) * 100
    end as ratio_tasa_crecimiento_vuelos_retrasados
from
    hecho_vuelos
join
    type_delays on hecho_vuelos.id_type_delay = type_delays.id_type_delay
join
    days on hecho_vuelos.id_day = days.id_day
join
    months on days.id_month = months.id_month
join
    years on months.id_year = years.id_year
where
    years.fl_year between 2019 and 2023
group by
    months.fl_season,
    type_delays.type_delay;
