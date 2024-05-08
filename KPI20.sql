/*
    KPI 20: revisar
    Tasa de crecimiento de los tiempos de aterrizaje de los vuelos 
    puntuales en las ciudades de destino por aerolínea. 
*/

select 
    airlines.airline,
    (avg(hecho_vuelos.arr_delay) - avg(hecho_vuelos.dep_delay)) / avg(hecho_vuelos.dep_delay) * 100 as tasa_crecimiento_tiempo_aterrizaje
from   
    hecho_vuelos
join
    cities on hecho_vuelos.code_dest_city = cities.code_city
join
    airlines on hecho_vuelos.code_airline = airlines.code_airline
join    
    days on hecho_vuelos.id_day = days.id_day   
join
    months on days.id_month = months.id_month
join
    years on months.id_year = years.id_year
where 
    hecho_vuelos.arr_delay > 0
group by
    airlines.airline;