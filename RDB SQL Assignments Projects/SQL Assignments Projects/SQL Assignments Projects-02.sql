/* Questions:
1- How many tracks does each album have? Your solution should include Album id and its number of tracks sorted from highest to lowest.

1- Her albümde kaç parça var? Çözümünüz, Albüm kimliğini ve en yüksekten en düşüğe sıralanmış parça sayısını içermelidir.

2- Find the album title of the tracks. Your solution should include track name and its album title.

2- Parçaların albüm başlığını bulun. Çözümünüz parça adını ve albüm başlığını içermelidir.

3- Find the minimum duration of the track in each album. Your solution should include album id, album title and duration of the track sorted from highest to lowest.

3- Her albümdeki parçanın minimum süresini bulun. Çözümünüz, en yüksekten en düşüğe doğru sıralanmış albüm kimliği, albüm başlığı ve parçanın süresini içermelidir.

4- Find the total duration of each album. Your solution should include album id, album title and its total duration sorted from highest to lowest.

4- Her albümün toplam süresini bulun. Çözümünüz albüm kimliği, albüm başlığı ve en yüksekten en düşüğe sıralanmış toplam süresini içermelidir.

5- Based on the previous question, find the albums whose total duration is higher than 70 minutes. Your solution should include album title and total duration.

5- Bir önceki soruya göre toplam süresi 70 dakikadan fazla olan albümleri bulun. Çözümünüz albüm başlığını ve toplam süreyi içermelidir. */


1------------Her albümde kaç parça var? Çözümünüz, Albüm kimliğini ve en yüksekten en düşüğe sıralanmış parça sayısını içermelidir.
SELECT COUNT(TrackId), AlbumId
FROM tracks
GROUP BY AlbumId
ORDER BY 1 DESC;

2--------SELECT tracks.name AS track_name, albums.Title AS album_title
FROM tracks
INNER JOIN albums ON albums.AlbumId=tracks.AlbumId;
6:32
3------SELECT MIN(Milliseconds), albums.AlbumId, albums.Title
FROM tracks
INNER JOIN albums ON albums.AlbumId=tracks.AlbumId
GROUP BY albums.AlbumId
ORDER BY MIN ( Milliseconds ) DESC;
6:33
4---------SELECT SUM ( Milliseconds ), albums.Title, albums.AlbumId
FROM tracks
INNER JOIN albums ON albums.AlbumId=tracks.AlbumId
GROUP BY albums.AlbumId
ORDER BY SUM ( Milliseconds ) DESC;
6:34
5------------SELECT SUM ( Milliseconds ), albums.Title
FROM tracks
INNER JOIN albums ON albums.AlbumId=tracks.AlbumId
GROUP BY albums.AlbumId
HAVING ( Milliseconds ) > 4200000;
------70 minute = 4200000 millisecond--------