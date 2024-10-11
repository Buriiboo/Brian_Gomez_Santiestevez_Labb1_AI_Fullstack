desc;

SELECT
    *
FROM
    information_schema.schemata;


CREATE SCHEMA IF NOT EXISTS marts;


CREATE TABLE IF NOT EXISTS marts.content_view_time AS 
(
    SELECT
        Videotitel,
        "Publiceringstid för video" AS Publiceringstid,
        Visningar,
        "Visningstid (timmar)" AS Visningstid_timmar,
        Exponeringar,
        Prenumeranter,
        "Klickfrekvens för exponeringar (%)" AS "Klickfrekvens_exponering_%"
    FROM
        innehall.tabelldata
    ORDER BY
        "Visningstid (timmar)" DESC
    OFFSET 1
);

-- Skapa 'views_per_date'-tabellen om den inte redan finns, med data från 'innehall.totalt'
CREATE TABLE IF NOT EXISTS marts.views_per_date AS 
(
    SELECT
        STRFTIME('%Y-%m-%d', Datum) AS Datum,
        Visningar
    FROM
        innehall.totalt
);

-- Skapa 'video_visningar_sorterade'-tabellen om den inte redan finns
CREATE TABLE IF NOT EXISTS marts.video_visningar_sorterade AS
(
    WITH video_visningar_sorterade AS (
        SELECT 
            Videotitel, 
            Visningar 
        FROM 
            innehall.tabelldata
        ORDER BY 
            Visningar DESC
    )
    SELECT * 
    FROM video_visningar_sorterade
);

-- Skapa 'videor_med_hoga_visningar'-tabellen om den inte redan finns
CREATE TABLE IF NOT EXISTS marts.videor_med_hoga_visningar AS
(
    WITH videor_med_hoga_visningar AS (
        SELECT 
            Videotitel, 
            Visningar 
        FROM 
            innehall.tabelldata
        WHERE 
            Visningar > 50
        ORDER BY 
            Visningar DESC
    )
    SELECT * 
    FROM videor_med_hoga_visningar
);

-- Skapa 'null_raknare_statistik'-tabellen om den inte redan finns
CREATE TABLE IF NOT EXISTS marts.null_raknare_statistik AS
(
    WITH null_raknare_statistik AS (
        SELECT 
            COUNT(*) AS totala_rader,                    -- Totalt antal rader
            COUNT(Videotitel) AS icke_null_titlar,       -- Antal icke-null videotitlar
            COUNT(Visningar) AS icke_null_visningar      -- Antal icke-null visningar
        FROM 
            innehall.tabelldata
    )
    SELECT * 
    FROM null_raknare_statistik
);

-- Visa alla tabeller i 'marts'-schemat
SELECT
    *
FROM
    information_schema.tables
WHERE
    table_schema = 'marts';

-- Visa innehållet i 'content_view_time'-tabellen
SELECT
    *
FROM
    marts.content_view_time;

-- Visa innehållet i 'views_per_date'-tabellen
SELECT
    *
FROM
    marts.views_per_date;

-- Visa innehållet i 'video_visningar_sorterade'-tabellen
SELECT
    *
FROM
    marts.video_visningar_sorterade;

-- Visa innehållet i 'videor_med_hoga_visningar'-tabellen
SELECT
    *
FROM
    marts.videor_med_hoga_visningar;

-- Visa innehållet i 'null_raknare_statistik'-tabellen
SELECT
    *
FROM
    marts.null_raknare_statistik;

   