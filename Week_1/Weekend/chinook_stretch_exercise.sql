/* SQL Stretch Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital 
 formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. 
 Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and 
 Employees report to other employees.
*/

SELECT * FROM invoice_items;
SELECT * FROM invoices;
--==================================================================
/* TASK I
How many audio tracks in total were bought by German customers? And what was the total price paid for them?
hint: use subquery to find all of tracks with their prices
*/

SELECT COUNT(DISTINCT invoice_items.TrackId), SUM(invoice_items.UnitPrice * invoice_items.Quantity) FROM invoice_items
    JOIN invoices ON invoices.InvoiceId = invoice_items.InvoiceId
    JOIN tracks ON invoice_items.TrackId = tracks.TrackId
    JOIN media_types ON tracks.MediaTypeId = media_types.MediaTypeId
    JOIN customers ON invoices.CustomerId = customers.CustomerId
    WHERE customers.Country = "Germany"
        AND media_types.Name LIKE "%audio%";

/* TASK II
What is the space, in bytes, occupied by the playlist “Grunge”, and how much would it cost?
(Assume that the cost of a playlist is the sum of the price of its constituent tracks).
*/

SELECT SUM(tracks.Bytes), SUM(tracks.UnitPrice) FROM tracks
    JOIN playlist_track ON tracks.TrackId = playlist_track.TrackId
    JOIN playlists ON playlist_track.PlaylistId = playlists.PlaylistId
    WHERE playlists.Name = "Grunge";

/* TASK III
List the names and the countries of those customers who are supported by an employee who was younger than 35 when hired. 
*/

SELECT customers.FirstName, customers.LastName, customers.Country FROM customers
    JOIN employees ON customers.SupportRepId = employees.EmployeeId
    WHERE strftime('%Y', employees.HireDate) - strftime('%Y', employees.BirthDate) < 35;
