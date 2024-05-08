/*
Porcentajes de vuelos por tipo de retraso entre los años 2019-2023.
*/

select avg(hv.arr_delay)  from hecho_vuelos hv where id_type_delay = 7 and  code_airline = 'WN'

SELECT 
    AIRLINES.airline, 
    TYPE_DELAYS.type_delay, 
    AVG(HECHO_VUELOS.arr_delay) as Promedio_Retrasos
FROM 
    HECHO_VUELOS
JOIN 
    AIRLINES ON HECHO_VUELOS.CODE_AIRLINE = AIRLINES.CODE_AIRLINE
JOIN 
    TYPE_DELAYS ON HECHO_VUELOS.ID_TYPE_DELAY = TYPE_DELAYS.id_type_delay
/*
permite buscar por airline y type_delay
WHERE 
    HECHO_VUELOS.ID_TYPE_DELAY = 7 
    AND HECHO_VUELOS.CODE_AIRLINE = 'WN'*/
GROUP BY 
    AIRLINES.airline, 
    TYPE_DELAYS.type_delay;