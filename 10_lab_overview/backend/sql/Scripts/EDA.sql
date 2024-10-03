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

SELECT * FROM tittare.tabelldata_alder ta; --info om tittarnas kön

SELECT * FROM tittare.tabelldata_kon tk; --info om tittarnas ålder


SELECT Videotitel, Visningar 
FROM innehall.tabelldata t
ORDER BY Visningar DESC; -- Visar videos med mest visningar.

SELECT Videotitel, Visningar 
FROM innehall.tabelldata
WHERE Visningar > 50 -- visar videos med över 50 views.
ORDER BY Visningar DESC;


SELECT 
    COUNT(*) AS total_rows, -- visar antal null och o-null
    COUNT(Videotitel) AS non_null_titles,        
    COUNT(Visningar) AS non_null_views          
FROM innehall.tabelldata;

