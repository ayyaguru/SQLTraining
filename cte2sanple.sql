use hospitalmanagment;

with recursive cte_date as(

select current_date() as date 
union all
select date_add(date,interval 1 day)  from cte_date where date <'2023-03-25'
)
select p.date,x.name as doctorname
from
(
select ntile(2)over(order by date) as slno, date from cte_date cte) as p
inner join (select row_number() over(partition by name order by name asc) as slno ,name,hospitalid from doctor) as x
on x.slno = p.slno
where x.hospitalid =1

with recursive cte_date as(

select current_date() as date 
union all
select date_add(date,interval 1 day)  from cte_date where date <'2023-03-25'
)
select p.date, x.name as doctorname
from
(select ntile(2) over(order by date asc) as slno, date  from cte_date) as p
inner join (select row_number() over(order by name asc) as slno , name, hospitalid from doctor dct
			where dct.hospitalid=1) as x
on p.slno=x.slno

use hospitalmanagment;
describe doctor;


Create view doctorview
As
select * from doctor;

select* from doctorview;

drop view AvailadoctorListView
create view AvailadoctorListView
As
select * from doctorview 
where status='Available'
with check option;

INSERT INTo AvailadoctorListView(hospitalid,name,status

INSERT INTo AvailadoctorListView(hospitalid,name,status)
values(1,'Peter','Available');

drop view hospitalview
create  view hospitalview
As
select dct.hospitalid, hsp.name as hospital, dct.name as doctorname, dct.status as doctorstatus 
,hsp.location 
from hospital hsp
INNER Join doctor dct on dct.hospitalid =hsp.id;

select location, count(distinct hospital) as hcount, count(distinct doctorname) as dcount from hospitalview
group by location



select * from AvailadoctorListView;
INSERT INTo doctorView(hospitalid,name,status)
values(1,'John','Available');
