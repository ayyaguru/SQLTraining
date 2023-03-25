use hospitalmanagment;
show databases;
/* procedure with the handler logic and handle the exception */
DROP PROCEDURE if exists InsertdoctorDetail
delimiter $$
CREATE Procedure InsertdoctorDetail(in hospitalname varchar(50), in doctorname varchar(100), 
in location varchar(250))
BEGIN
Declare hospitalid int;
declare code char(5) default '00000';
declare emsg varchar(250);
declare exit  handler for sqlexception 
begin
get current diagnostics condition 1 
code=RETURNED_SQLState, 
emsg=Message_TEXT;
ROLLBACK;
SELECT code, emsg;
end;

start TRANSACTION;
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
SELECT doctorname, hospitalid
where not exists(select *  from doctor 
				  where name = doctorname
                  and hospitalid =hospitalid);
                  
COMMIT;	
END$$
delimiter ;
call InsertdoctorDetail('DeepamChildCare','jdahjfhjdhfjkdsahjkdjsdhsdkjfhjksdhjksdjkdshjksdhjkdshj','chrompet');


select row_number() over(partition by hsp.name order by dct.name asc) as RowNumber, name as doctorname , dct.name as hospitalname
from doctor dct 
INNER join hospital hsp on hsp.id =dct.hospitalid;

/* Row number used to  generate a serial number*/
SELECT row_number() over(partition by hname order by dname asc) as RowNumber, hname, dname
FROM 
(Select hsp.name as hname, dct.name as dname 
from hospital hsp
inner join doctor dct on dct.hospitalid = hsp.Id) as x;

/* Rank function with order by */
SELECT Rank() over( order by hname asc) as RowNumber, hname, dname
FROM 
(Select hsp.name as hname, dct.name as dname 
from hospital hsp
inner join doctor dct on dct.hospitalid = hsp.Id) as x;

/*ntile to split the  record by set of group */
SELECT ntile(2) over(partition by hname order by dname asc) as RowNumber, hname, dname
FROM 
(Select hsp.name as hname, dct.name as dname 
from hospital hsp
inner join doctor dct on dct.hospitalid = hsp.Id) as x;




/*Rank with partition*/
SELECT Rank() over(partition by hname order by dname asc) as RowNumber, hname, dname
FROM 
(Select hsp.name as hname, dct.name as dname 
from hospital hsp
inner join doctor dct on dct.hospitalid = hsp.Id) as x;

/*dynamic sql query*/
set @query ='select * from doctor';
PREPARE st from @query;
Execute st;



