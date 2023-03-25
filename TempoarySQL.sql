

/* Location wise hospital and doctor count*/

DROP PRocedure if exists GetLocationSummary
delimiter $$
create procedure GetLocationSummary()
BEGIN
	
    DROP temporary table if exists tmpLocation;
    CREATE temporary table tmpLocation
    SELECT hsp.name as Hname, location , dct.name as dname
    FROM Hospital hsp
    INNER JOIN doctor dct on dct.hospitalId =hsp.id;
    
    SELECT location, count(distinct hname) as hcount 
    , count(distinct  dname) as dcount
    FROM tmpLocation
    group by location;

END$$
Delimiter ;

call GetLocationSummary();

/*derived table */

drop procedure if exists GetDerivedlocation
delimiter $$
create procedure GetDerivedlocation()
begin
	
    SELECT location, count(distinct hname) as hcount
    ,count(distinct dname) as dcount
    FROM 
    (Select hsp.name as hname, dct.name as dname,
	hsp.location from hospital hsp
    inner join doctor dct on dct.hospitalid = hsp.id) as x
	group by x.location;

END$$
delimiter ;
call GetDerivedlocation();

/* CTE Query sample to get the location Summary*/
DROP PROCEDURE IF ExISTS GetCTELocationSummary
delimiter $$
CREATE PROCEDURE GetCTELocationSummary()
BEGIN
	
with cte_location(hname,dname,location) as (
SELECT hsp.name as hname, dct.name as dname
,location  
from hospital hsp
INNER JOIN doctor dct on dct.hospitalid =hsp.id)
SELECT location, count(distinct hname) as hcount, 
count(distinct dname) as dcount 
FROM cte_location
group by location;
END$$
delimiter ;

call GetCTELocationSummary()

/* Insert doctor info using exists */
DROP PROCEDURE if exists InsertdoctorDetail
delimiter $$
CREATE Procedure InsertdoctorDetail(in hospitalname varchar(50), in doctorname varchar(100), 
in location varchar(250))
BEGIN
Declare hospitalid int;

INSERT INTo Hospital(name,location)
SELECT hospitalname, location
Where not exists(select *  from Hospital  hsp
			 where hsp.name =hospitalname
             and hsp.location =location);
If (select count(*) from hospital 
	where name =hospitalname and location =  location)>0 Then
    set hospitalid = (Select id from hospital 
						where name =hospitalname and location =location
                        Limit 1);
ELSE
SET hospitalid = last_insert_id();
end if;

INSERT INTo doctor(name,hospitalid)
SELECT doctorname,hospitalid
where not exists(select *  from doctor 
				  where name = doctorname
                  and hospitalid =hospitalid);
                  
	
END$$
delimiter ;

call InsertdoctorDetail('Apollo','viji','Adayar')




