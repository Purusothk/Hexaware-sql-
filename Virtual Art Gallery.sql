create database Virtual1

use Virtual1

CREATE TABLE Artists (
 ArtistID INT PRIMARY KEY,
 Name VARCHAR(255) NOT NULL,
 Biography TEXT,
 Nationality VARCHAR(100));

 CREATE TABLE Categories (
 CategoryID INT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL);

 
 create table Artworks (
    ArtworkID int primary key,
    Title varchar(255) not null,
    ArtistID int not null,  
    CategoryID int,
    Year int,
    Description text,
    ImageURL varchar(255),
    Price decimal(10, 2),  
    Status varchar(50) default 'Available',  
    foreign key (ArtistID) references Artists (ArtistID) on delete cascade,   
    foreign key (CategoryID) references Categories (CategoryID) on delete set null   
);

 CREATE TABLE Exhibitions (
 ExhibitionID INT PRIMARY KEY,
 Title VARCHAR(255) NOT NULL,
 StartDate DATE,
 EndDate DATE,
 Description TEXT);


 CREATE TABLE ExhibitionArtworks (
 ExhibitionID INT,
 ArtworkID INT,
 PRIMARY KEY (ExhibitionID, ArtworkID),
 FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
 FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID));

 INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
 (1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
 (2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
 (3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

 INSERT INTO Categories (CategoryID, Name) VALUES
 (1, 'Painting'),
 (2, 'Sculpture'),
 (3, 'Photography');

 INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL, Price, Status) VALUES
(1, 'The Weeping Woman', 1, 1, 1937, 'A famous painting by Pablo Picasso.', 'weeping_woman.jpg', 750000, 'Available'),
(2, 'The Starry Night Over the Rhône', 2, 1, 1888, 'Another version of Starry Night by van Gogh.', 'starry_night_rhone.jpg', 850000, 'Available'),
(3, 'The Last Supper', 3, 2, 1495, 'A large mural by Leonardo da Vinci.', 'last_supper.jpg', 1800000, 'Sold');

 INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
 (1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
 (2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.'); INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
 (1, 1),
 (1, 2),
 (1, 3),
 (2, 2);--1. Retrieve the names of all artists along with the number 
-- of artworks they have in the gallery, and
-- list them in descending order of the number of artworks.select a.Name as ArtistName, count(aw.ArtworkID) AS NumberOfArtworks
FROM Artists a left join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name order by NumberOfArtworks DESC--2.List the titles of artworks created by artists from 
--'Spanish' and 'Dutch' nationalities, and order
--them by the year in ascending order.

select a.Title, ar.Nationality,a.Year  from Artworks a join Artists ar 
on a.ArtistID = ar.ArtistID where ar.Nationality in('Spanish','Dutch')
order by a.Year

--3.Find the names of all artists who have artworks 
--in the 'Painting' category, and the number of
--artworks they have in this category.
select ar.Name,count(a.ArtworkID) as count from Artists ar 
join Artworks a on a.ArtistID = ar.ArtistID
join Categories c on a.CategoryID = c.CategoryID
where c.Name = 'Painting'
group by ar.Name

--4. List the names of artworks from the 'Modern Art Masterpieces' exhibition, 
--along with their artists and categories.select  a.Title AS ArtworkTitle, ar.Name AS ArtistName, c.Name AS CategoryName
from  ExhibitionArtworks ea
join Artworks a on ea.ArtworkID = a.ArtworkID
join Artists ar on a.ArtistID = ar.ArtistID
join Categories c on a.CategoryID = c.CategoryID
join Exhibitions e on ea.ExhibitionID = e.ExhibitionID
where e.Title = 'Modern Art Masterpieces'--5. Find the artists who have more than two artworks in the gallery.select ar.Name ,count(a.ArtworkID) AS ArtworkCount
from Artworks a
join Artists ar ON a.ArtistID = ar.ArtistID
group by ar.Name
having count(a.ArtworkID) > 2--6.Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and
--'Renaissance Art' exhibitionsselect aw.title as Title
from artworks aw
join exhibitionartworks ea on aw.artworkid = ea.artworkid
join exhibitions e on ea.exhibitionid = e.exhibitionid
where e.title in ('Modern Art Masterpieces', 'Renaissance Art')
group by aw.title
having count(e.title) = 2;

--7. Find the total number of artworks in each category
select c.Name as CategoryName, count(aw.ArtworkID) as  Artworkcnt
from Categories c
join Artworks aw on c.CategoryID = aw.CategoryID
group by c.Name

--8. List artists who have more than 3 artworks in the gallery
select a.Name   from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name having count(aw.ArtworkID) > 3

--9. Find the artworks created by artists from a specific nationality (e.g., Spanish)
select a.Title, ar.Name AS ArtistName, ar.Nationality
from Artworks a 
join Artists ar ON a.ArtistID = ar.ArtistID
where ar.Nationality = 'Spanish'


--10. List exhibitions that feature artwork by both Vincent van Gogh 
--and Leonardo da Vinci.
-- doubt
select e.Title AS ExhibitionTitle from Exhibitions e
join ExhibitionArtworks ea ON e.ExhibitionID = ea.ExhibitionID
join Artworks a ON ea.ArtworkID = a.ArtworkID
join Artists ar ON a.ArtistID = ar.ArtistID
where ar.Name IN ('Vincent van Gogh', 'Leonardo da Vinci')
group by  e.Title
having count(distinct ar.ArtistID) = 2

--11. Find all the artworks that have not been included in any exhibition.select a.Title 
from Artworks a
left join ExhibitionArtworks e1 ON a.ArtworkID = e1.ArtworkID
where e1.ExhibitionID IS NULL

--12.List artists who have created artworks in all available categories.
select ar.Name
from Artworks a
join Artists ar on a.ArtistID = ar.ArtistID
join Categories c on a.CategoryID = c.CategoryID
group by ar.ArtistID, ar.Name
having count(distinct a.CategoryID) = (SELECT COUNT(*) FROM Categories)
--13 List the total number of artworks in each category--same as 7th questions
select c.Name as CategoryName, count(aw.ArtworkID) as  Artworkcnt
from Categories c
join Artworks aw on c.CategoryID = aw.CategoryID
group by c.Name

--14. Find the artists who have more than 2 artworks in the gallery
select a.Name   from Artists a
join Artworks aw on a.ArtistID = aw.ArtistID
group by a.Name having count(aw.ArtworkID) > 2

--15.List the categories with the average year of artworks they contain, 
--only for categories with more than 1 artwork.

select c.Name as CategoryName, avg(a.Year) as AverageYear
from Categories c
JOIN Artworks a on c.CategoryID = a.CategoryID
group by c.Name
having count(a.ArtworkID) > 1;


--16. Find the artworks that were exhibited in the --'Modern Art Masterpieces' exhibitionselect a.ArtworkID from Artworks ajoin ExhibitionArtworks ea on a.ArtworkID = ea.ArtworkIDjoin Exhibitions e on e.ExhibitionID = ea.ExhibitionIDwhere e.Title = 'Modern Art Masterpieces'--17.Find the categories where the average year of artworks is greater 
--than the average year of all artworks.select c.CategoryID, c.Name from Categories cjoin Artworks a on a.CategoryID = c.CategoryID group by C.CategoryID,c.Namehaving avg(a.year)>(select avg(year) from Artworks)--18.List the artworks that were not exhibited in any exhibition--same as question 11
select a.Title 
from Artworks a
left join ExhibitionArtworks e1 ON a.ArtworkID = e1.ArtworkID
where e1.ExhibitionID IS NULL

--19. Show artists who have artworks in the same category as "Mona Lisa."

select distinct ar.Name 
from Artists ar JOIN Artworks a on ar.ArtistID = a.ArtistID
WHERE a.Title =
(select Title from Artworks where Title = 'Mona Lisa')

--20.List the names of artists and the number of artworks they have in the gallery.

select ar.Name, count(a.ArtworkID) AS ArtworkCount
from Artists ar
left join Artworks a on ar.ArtistID = a.ArtistID
group by ar.Name
order by ArtworkCount desc;