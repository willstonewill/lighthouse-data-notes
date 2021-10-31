/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital 
 formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. 
 Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and 
 Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/

SELECT DISTINCT Name FROM 
    (SELECT * FROM artists LEFT OUTER JOIN albums ON artists.ArtistId = albums.ArtistId) 
    WHERE AlbumId ISNULL;


/* TASK II
Which artists recorded any tracks of the Latin genre?
*/

SELECT DISTINCT artists.Name FROM artists JOIN albums ON artists.ArtistId = albums.ArtistId
    JOIN tracks ON albums.AlbumId = tracks.AlbumId
    JOIN genres ON tracks.GenreId = genres.GenreId
    WHERE genres.Name = "Latin";

/* TASK III
Which video track has the longest length?
*/

SELECT Name FROM (SELECT tracks.Name, MAX(tracks.Milliseconds) AS length FROM 
                        tracks JOIN media_types ON tracks.MediaTypeId = media_types.MediaTypeId
                        GROUP BY tracks.Name
                        ORDER BY length
                        DESC)
            LIMIT 1;


/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/

SELECT * 
    FROM customers JOIN employees ON customers.City = employees.City
    WHERE employees.ReportsTo ISNULL;


/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT DISTINCT em.FirstName, em.LastName
    FROM employees e JOIN customers c ON e.EmployeeId = c.SupportRepId
        JOIN employees em ON e.ReportsTo = em.EmployeeId
    WHERE c.Country = "Brazil" AND em.Title LIKE "%Manager%";

/* TASK VI
Which playlists have no Latin tracks?
*/

/* Below are my exploration for this task
SELECT * FROM playlists JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
                Join tracks ON playlist_track.TrackId = tracks.TrackId;

SELECT * FROM playlists;

SELECT DISTINCT Name FROM genres;

SELECT DISTINCT playlists.PlaylistId, playlists.Name, genres.Name FROM playlists
        JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
        JOIN tracks ON playlist_track.TrackId = tracks.TrackId
        JOIN genres ON tracks.GenreId = genres.GenreId
        WHERE genres.Name = "Latin";
*/

SELECT playlists.PlaylistId, playlists.Name FROM playlists
    WHERE playlists.PlaylistId NOT IN
    (SELECT DISTINCT playlists.PlaylistId FROM playlists
        JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
        JOIN tracks ON playlist_track.TrackId = tracks.TrackId
        JOIN genres ON tracks.GenreId = genres.GenreId
        WHERE genres.Name = "Latin");
