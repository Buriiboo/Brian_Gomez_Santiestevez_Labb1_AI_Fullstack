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