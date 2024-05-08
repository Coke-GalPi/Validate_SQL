/*
    KPI 12:
    Ratio de porcentajes de vuelos realizados por ruta y que sufrieron
    cancelaciones por aerolínea entre los años 2019-2023
*/

select 
    routes.code_route,
    routes.route,
    airlines.airline,
    (cast(count(case when hecho_vuelos.id_state_flights = 2 then 1 end) as decimal) / count(hecho_vuelos.id_vuelo)) * 100 as proporcion_vuelos_estado_2_porcentaje
from 
    hecho_vuelos
join 
    routes on hecho_vuelos.code_route = routes.code_route 
join 
    airlines on hecho_vuelos.code_airline = airlines.code_airline
join 
    days on hecho_vuelos.id_day = days.id_day
join 
    months on days.id_month = months.id_month
join 
    years on months.id_year = years.id_year
where 
    years.id_year between 2019 and 2023
group by 
    routes.code_route,
    routes.route,
    airlines.airline;


