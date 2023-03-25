use hospitalmanagment;
alter TABLE doctor ADD Status varchar(15);

select * from doctor;
Update doctor  set status='Dleave' 
where Id IN(1003)
select * from doctor where status='Leave'
select status, count(*) from doctor 
group by status
select hsp.name as hospitalname , sum( case when status='Training' THEN 1 ELSE 0 END) As 'Training',
sum( case when status='Available' THEN 1 ELSE 0 END) As 'Available',
sum( case when status='DLeave' THEN 1 ELSE 0 END) As 'DLeave'
FROM hospital hsp
INNER JOIN doctor dct on dct.hospitalid = hsp.id
group by hsp.name

SET @sql='';
SELECT group_concat( distinct concat('SUM(case when status="',status,'" THEN 1 ELSE 0 END) As ', status))
INTO @sql
FROM doctor;
SET @sql =CONCAT('SELECT hsp.name as hospitalname,',@sql,
' FROM hospital hsp INNER JOIN doctor dct on dct.hospitalid = hsp.Id group by hsp.name ');
select @sql;
PREPARE st from @sql;
EXECUTE st;
Deallocate prepare st;

with recursive cte_date as(

select current_date() as date 
union all
select date_add(date,interval 1 day)  from cte_date where date <='2023-03-25'
)
select * from cte_date


