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




WITH
-- CTE för att hämta alla videotitlar och visningar, sorterat efter antal visningar
video_visningar_sorterade AS (
    SELECT 
        Videotitel, 
        Visningar 
    FROM 
        innehall.tabelldata
    ORDER BY 
        Visningar DESC
),

-- CTE för att filtrera videor med mer än 50 visningar
videor_med_hoga_visningar AS (
    SELECT 
        Videotitel, 
        Visningar 
    FROM 
        innehall.tabelldata
    WHERE 
        Visningar > 50
    ORDER BY 
        Visningar DESC
),

-- CTE för att räkna totala rader och antal icke-null-värden i kolumnerna
null_raknare_statistik AS (
    SELECT 
        COUNT(*) AS totala_rader,                    -- Totalt antal rader
        COUNT(Videotitel) AS icke_null_titlar,       -- Antal icke-null videotitlar
        COUNT(Visningar) AS icke_null_visningar      -- Antal icke-null visningar
    FROM 
        innehall.tabelldata
)

-- Väljer från de definierade CTE:erna
SELECT * 
FROM video_visningar_sorterade;  -- Fråga 1: Visar alla videor sorterade efter antal visningar

SELECT * 
FROM videor_med_hoga_visningar;  -- Fråga 2: Visar videor med mer än 50 visningar

SELECT * 
FROM null_raknare_statistik;  -- Fråga 3: Visar statistik över null- och icke-null-värden
