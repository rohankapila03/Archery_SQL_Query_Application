#1
select Fname, Lname, Country
	from participant;

#2:
select fname,lname,country
     from participant
     where participant.OlympicID in(
     select OlympicID
     from coach
     where orientation = "pending"
     );

#3
select Country, count(*) from participant group by country;

#4
select olympicID, IFNull(BirthYear, "null")
    from athlete
    order by BirthYear asc;

#5
select Country from participant group by country having count(*) > 1;

#6
select fname,lname
     from participant
     where participant.OlympicID in(
     select Olympian
     from individual_results
    );

#7
select CName
from Country
where (AllTimeGold + AllTimeSilver + AllTimeBronze) > 5;

#8
select cname,(alltimegold + alltimesilver + alltimebronze)
    from country
    where country.cname in(
    select participant.country
    from participant
    where participant.OlympicID in(
    select olympian
    from individual_results));

#9
select participant.Fname, participant.Lname
from participant
where participant.OlympicId IN(
	select athlete.OlympicId
    from athlete
    where athlete.FirstGames = 'Tokyo 2020');

#10
select fname, lname
    from participant
    where participant.OlympicID in(
    select athlete.OlympicID
    from athlete
    where athlete.birthyear = (select max(birthyear) from athlete) or
    athlete.birthyear = (select min(birthyear) from athlete)
    order by athlete.birthyear desc
    );

#11
drop view if exists `TEAM_ATHLETES`;
create view TEAM_ATHLETES as
select Concat(Fname, ' ',Lname) AS FullName, BirthYear
    from participant 
    right join athlete
    on participant.OlympicID = athlete.OlympicID;
select * from `TEAM_ATHLETES`
order by birthyear desc;

#12
Create table INDIVID_W (
    EventDate varchar(15) not null,
    VenueName varchar(30) not null,
    LName varchar(25) not null,
    Country varchar(30) not null,
    primary key (Lname),
    foreign key (Country) references Country(Cname)
    );
insert into INDIVID_W (EventDate, VenueName, LName, Country)
     Values
     ('July 30', 'Dream Island Archery Field', 'An', 'Republic of Korea'),
     ('July 30', 'Dream Island Archery Field', 'Barbelin', 'France'),
     ('July 30', 'Dream Island Archery Field', 'Bayardo', 'Netherlands'),
     ('July 30', 'Dream Island Archery Field', 'Boari', 'Italy'),
     ('July 30', 'Dream Island Archery Field', 'Brown', 'United States of America'),
     ('July 30', 'Dream Island Archery Field', 'Gobmboeva', 'ROC'),
     ('July 30', 'Dream Island Archery Field', 'Jang', 'Republic of Korea'),
     ('July 30', 'Dream Island Archery Field', 'Kang', 'Republic of Korea'),
     ('July 30', 'Dream Island Archery Field', 'Kroppen', 'Germany'),
     ('July 30', 'Dream Island Archery Field', 'Kumari', 'India'),
     ('July 30', 'Dream Island Archery Field', 'Marusava', 'Belarus'),
     ('July 30', 'Dream Island Archery Field', 'Osipova', 'ROC'),
     ('July 30', 'Dream Island Archery Field', 'Roman', 'Mexico'),
     ('July 30', 'Dream Island Archery Field', 'Schwarz', 'Germany'),
     ('July 30', 'Dream Island Archery Field', 'Unruh', 'Germany'),
     ('July 30', 'Dream Island Archery Field', 'Valencia', 'Mexico'),
     ('July 30', 'Dream Island Archery Field', 'Vazquez', 'Mexico'),
     ('July 30', 'Dream Island Archery Field', 'Wu', "People's Republic of China");


#13
INSERT INTO COACH VALUES ('T2020_046', 'Pending');
/*	This query will not be able to run because it is trying to update a 'child row'.
It's trying to add a row but there is no matching row in the table. This operation tries to create a foreign
key value but it is constrained since a foreign key is specified.
*/

#14
DELETE FROM PARTICIPANT WHERE OlympicID = 'T2020_001';
/*	This query would fail because it is trying to delete a 'child row' The entry it's
trying to delete is a foreign key in some other table. So if we wanted this to work we would have to 
drop the foreign keys in the other tables and then delete in from PARTICIPANT.
*/

#15
/*A new constraint that could be considered for the TEAM table would be to add EventID as a foreign key.
This would be useful in specifying what the composition of each team is: for example, because we are not
given names or gender, we could instead use EventID to identify the members and make sure the
proper ID’s are associated with each event (i.e. a male contestant would not be able to
join a team competing in a Women’s event). This would have to 
involve the Event_Schedule table in order to get the foreign key.*/
