WITH 
	date_table AS (SELECT * FROM datum.tabelldata OFFSET 1),
	date_total AS (SELECT * FROM datum.totalt OFFSET 1)
SELECT 
	STRFTIME('%Y-%m-%d', tot.datum), 
	tot.visningar,
	tab.visningar,
	tab."visningstid (timmar)"
FROM date_total as tot
LEFT JOIN date_table as tab 
ON tot.datum = tab.datum;



SELECT Enhetstyp, count(*) total_rows, sum(Visningar) as total_visningar 
from 
enhetstyp.diagramdata group by Enhetstyp ;

select * from enhetstyp.diagramdata d ;

SELECT * EXCLUDE (Innehåll) FROM  innehall.tabelldata ORDER BY "Visningstid (timmar)" DESC OFFSET 1 LIMIT 5;

SELECT * FROM  innehall.diagramdata;-- ORDER BY "Visningstid (timmar)";

SELECT STRFTIME('%Y-%m-%d', Datum), Visningar FROM innehall.totalt;



desc;

WITH date_table AS (
SELECT
	*
FROM
	datum.tabelldata),
date_total AS (
SELECT
	*
FROM
	datum.totalt)
SELECT
	*
FROM
	date_total;

/*
SELECT 
    COUNT(*) AS total_sub,                       
    AVG("Tittarnas ålder") AS average_age,                
    MIN("Tittarnas ålder") AS min_age,                
    MAX("Tittarnas ålder") AS max_age                       
FROM 
    tittare.tabelldata_kon;
*/
   
   
   
SELECT * FROM tittare.tabelldata_kon tk --visar tittarnas ålder och statistik kring ålder.

SELECT * FROM tittare.tabelldata_alder ta --visar vilka tittare som är intresserade i kanalen.

