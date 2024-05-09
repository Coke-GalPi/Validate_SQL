/*
    KPI 9: Listo
    Ratio de Variabilidad de Puntualidad por Ruta y Estación del Año.
*/

select 
    routes.route,
    months.fl_season,
    (var_samp(hecho_vuelos.arr_delay) / avg(hecho_vuelos.arr_delay)) as ratio_variabilidad_puntualidad
from
    hecho_vuelos
join
    routes on hecho_vuelos.code_route = routes.code_route
join
    days on hecho_vuelos.id_day = days.id_day
join
    months on days.id_month = months.id_month
join
    years on months.id_year = years.id_year
where
    years.fl_year between 2019 and 2023
    /*(years.fl_year between 2019 and 2023) and
    (fl_season = 'season') and
    routes.route = 'route'*/
group by
    routes.route,
    months.fl_season;