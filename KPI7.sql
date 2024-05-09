/* 
    KPI 7: buscar como hacer 
    Tasa de crecimiento de vuelos por estación del año entre los años 2019-2023.
*/
select
    years.fl_year,
    months.fl_season,
    count(hecho_vuelos.id_vuelo) as total_vuelos,
    (
        count(hecho_vuelos.id_vuelo) - lag(count(hecho_vuelos.id_vuelo), 1) over (partition by months.fl_season order by years.fl_year)) 
        / 
        lag(count(hecho_vuelos.id_vuelo), 1) over (partition by months.month order by years.fl_year) * 100 as tasa_crecimiento
from
    hecho_vuelos
join days on hecho_vuelos.id_day = days.id_day
join months on days.id_month = months.id_month
join years on months.id_year = years.id_year
where
    years.fl_year between 2019 and 2023
group by
    years.fl_year,
    months.fl_season;


select
    years.fl_year,
    months.fl_season,
    count(hecho_vuelos.id_vuelo) as total_vuelos,
    (
        (count(hecho_vuelos.id_vuelo) - lag(count(hecho_vuelos.id_vuelo), 1) over (partition by months.fl_season order by years.fl_year)) /
        lag(count(hecho_vuelos.id_vuelo), 1) over (partition by months.fl_season order by years.fl_year)
    ) * 100 as tasa_crecimiento
from
    hecho_vuelos
join days on hecho_vuelos.id_day = days.id_day
join months on days.id_month = months.id_month
join years on months.id_year = years.id_year
where
    years.fl_year between 2019 and 2023
group by
    years.fl_year,
    months.fl_season;

