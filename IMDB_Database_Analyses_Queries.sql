set echo on 

describe imdb00.name_basics
describe imdb00.title_basics
describe imdb00.title_principals

-- checking first n rows to see schema structure 
select tb.TCONST ||','|| tb.titletype ||','|| tb.primarytitle ||','|| tb.originaltitle ||','|| tb.isadult ||','|| tb.startyear ||','|| tb.endyear ||','|| tb.runtimeminutes ||','|| tb.genres
    from imdb00.title_basics tb
    fetch first 3 rows only;

TB.TCONST||','||TB.TITLETYPE||','||TB.PRIMARYTITLE||','||TB.ORIGINALTITLE||','||TB.ISADULT||','||TB.STARTYEAR||','||TB.ENDYEAR||','||TB.RUNTIMEMINUTES||','||TB.GENRES
-- ANALYSIS 1A: Span of acting career in years each actor/actress have been participating using the database along w/ total # of movies made in each year

-- QUERY: USING NAMEID TO OBTAIN # OF MOVIES PER YEAR OVER ACTIVE CAREER (JULIE ANDREWS)

SELECT NB.primaryname||','||TB.startyear||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        NB.nconst = 'nm0000267' AND -- Looking for artist with this ID number within the name basics table where nconst represents the column containing id's
        LOWER(TB.titleType) = 'movie' AND -- we are specifically interested in the movie category, as some actors/actresses do TV Shows and movies, it is important that the movie is the title type
        LOWER(TP.category) IN ('actress') AND TB.startyear NOT LIKE '\N' -- we are interested in the actress Julie Andrews therefore we must specify that we are looking in the actress column, furthermore, we want to make sure that the query is not case sensitive
GROUP BY NB.nconst, NB.primaryname, TB.startyear -- grouping by the id, name, and the year the movies were shot 
ORDER BY TB.startyear ASC; -- sorting by the earliest movie that was released to the most recent 

-- QUERY: USING NAMEID TO OBTAIN # OF MOVIES PER YEAR OVER ACTIVE CAREER (BRUCE LEE); same approach is being used for the three other queries as explained above

SELECT NB.primaryname||','||TB.startyear||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        NB.nconst = 'nm0000045' AND
        LOWER(TB.titleType) = 'movie' AND
        LOWER(TP.category) IN ('actor') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname, TB.startyear
ORDER BY TB.startyear ASC;

-- QUERY: USING NAMEID TO OBTAIN # OF MOVIES PER YEAR OVER ACTIVE CAREER (AUDREY HEPBURN)
SELECT NB.primaryname||','||TB.startyear||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        NB.nconst = 'nm0000030' AND
        LOWER(TB.titleType) = 'movie' AND
        LOWER(TP.category) IN ('actress') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname, TB.startyear
ORDER BY TB.startyear ASC;

-- QUERY: USING NAMEID TO OBTAIN # OF MOVIES PER YEAR OVER ACTIVE CAREER (KIRK DOUGLAS)
SELECT NB.primaryname||','||TB.startyear||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        NB.nconst = 'nm0000018' AND
        LOWER(TB.titleType) = 'movie' AND
        LOWER(TP.category) IN ('actor') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname, TB.startyear
ORDER BY TB.startyear ASC;

-- ANALYSIS 1B: Divide the span into 4 or 5 disjoint periods and comput the total number of movies the actor/actress has participated in (in any genre) in each period
-- to track and visualize their career progress. (visualization done using python -- line graph)

-- QUERY: 
SELECT NB.primaryname||','||TB.startyear||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        NB.nconst IN ('nm0000018','nm0000267','nm0000030','nm0000045') AND -- specifying all id's we are interested in 
        TB.startyear BETWEEN '1941' AND '1961' AND -- want to get the number of movies each actor and actress participated in between this first period
        LOWER(TB.titleType) = 'movie' AND -- we are only interested in movies 
        LOWER(TP.category) IN ('actor','actress') AND TB.startyear NOT LIKE '\N' -- interested in both actors and actresses 
GROUP BY NB.nconst, NB.primaryname, TB.startyear
ORDER BY TB.startyear ASC;

SELECT NB.primaryname||','||TB.startyear||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        NB.nconst IN ('nm0000018','nm0000267','nm0000030','nm0000045') AND 
        TB.startyear BETWEEN '1962' AND '1981' AND
        LOWER(TB.titleType) = 'movie' AND
        LOWER(TP.category) IN ('actor','actress') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname, TB.startyear
ORDER BY TB.startyear ASC;

SELECT NB.primaryname||','||TB.startyear||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        NB.nconst IN ('nm0000018','nm0000267','nm0000030','nm0000045') AND 
        TB.startyear BETWEEN '1982' AND '2001' AND
        LOWER(TB.titleType) = 'movie' AND
        LOWER(TP.category) IN ('actor','actress') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname, TB.startyear
ORDER BY TB.startyear ASC;

SELECT NB.primaryname||','||TB.startyear||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        NB.nconst IN ('nm0000018','nm0000267','nm0000030','nm0000045') AND 
        TB.startyear BETWEEN '2002' AND '2022' AND
        LOWER(TB.titleType) = 'movie' AND
        LOWER(TP.category) IN ('actor','actress') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname, TB.startyear
ORDER BY TB.startyear ASC;

-- ANALYSIS 1C: Compare the actors/actresses chosen for each period over their acting career life using visualization (done using python -- bar chart or maybe pie chart) 
-- Python


-- ANALYSIS 2: Find any actor and actress who have done the maximum number of movies and minimum number of movies between 1968-1977 (using nconst, start year, and end year)

--QUERY:
-- MAX number of movies done between 10 year period (actresses)
SELECT NB.nconst||','||NB.primaryname||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        TB.startyear BETWEEN '1968' AND '1977' AND -- time period we are interested in 
        LOWER(TB.titleType) = 'movie' AND -- title type we are interested in 
        LOWER(TP.category) IN ('actress') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname
ORDER BY COUNT(*) DESC FETCH first 1 row ONLY; -- will fetch the first row only which will return the MAX number of movies done by an actress during this time period

-- MIN number of movies done between 10 year period (actress)
SELECT NB.nconst||','||NB.primaryname||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        TB.startyear BETWEEN '1968' AND '1977' AND
        LOWER(TB.titleType) = 'movie' AND
        LOWER(TP.category) IN ('actress') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname HAVING COUNT(*) >= 3
ORDER BY COUNT(*) ASC FETCH first 3 rows ONLY;

-- MAX number of movies done between 10 year period (actor)
SELECT NB.nconst||','||NB.primaryname||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        TB.startyear BETWEEN '1968' AND '1977' AND
        LOWER(TB.titleType) = 'movie' AND
        LOWER(TP.category) IN ('actor') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname
ORDER BY COUNT(*) DESC FETCH first 1 row ONLY;

-- MIN number of movies done between 10 year period (actor)
SELECT NB.nconst||','||NB.primaryname||','||COUNT(*)
FROM imdb00.name_basics NB, imdb00.title_principals TP, imdb00.title_basics TB
WHERE NB.nconst = TP.nconst AND
        TP.tconst = TB.tconst AND
        TB.startyear BETWEEN '1968' AND '1977' AND
        LOWER(TB.titleType) = 'movie' AND
        LOWER(TP.category) IN ('actor') AND TB.startyear NOT LIKE '\N'
GROUP BY NB.nconst, NB.primaryname HAVING COUNT(*) >= 3
ORDER BY COUNT(*) ASC FETCH first 3 rows ONLY;
 