use hospitalmanagment;

select *  from Doctor;

select *  from doctor where hospitalid =1;

select*
FROM(
select dense_rank() over(order by salary desc) as srank , name ,id, salary
FROM doctor
where hospitalid =1) as x
WHERe x.srank =4
use hospitalmanagment;
Create Table doctorShift(Id int Primary key Auto_increment ,doctorid int , shiftdate date);

use hospitalmanagment;

select * from doctorShift
delete from doctorshift
where id <9



truncate table doctorShift;

/*To Enable a Scheduler */
SET Global event_scheduler =1;

CREATE EVENT IF NOT EXISTS Doctor_Shift
ON Schedule EVERY 1 MINUTE
DO
INSERT INTO doctorShift(doctorid,shiftdate)
SELECT Id,current_date()
FROM doctor dct
WHERE NOT EXISTS(SELEct 1 FROM doctorShift sft	
				WHERE sft.doctorid =dct.id
                and sft.shiftdate=current_date())
AND dct.status='Available';

--
select * from doctor; 

select Age, Avg(salary) from doctor 
Group by Age 
UNION ALL
SELECT 'Total Avg Salary', Avg(Salary) from doctor ;

select if(grouping(Age),'Total Avg Salary',Age) as Age, Avg(salary) from doctor 
Group by Age
WITH ROLLUP;
select * from doctorShift;
truncate table doctorShift;

ALTER TABLE Doctor AdD fulltext (name,specialist); 

select * from Doctor;
UPDATE Doctor SET specialist ='Allergists/Immunologists'
WHERE id =1000;
UPDATE Doctor SET specialist ='Anesthesiologists'
WHERE id =1002;
UPDATE Doctor SET specialist ='Cardiologists'
WHERE id =1003;
UPDATE Doctor SET specialist ='Colon and Rectal Surgeons'
WHERE id =1004;
UPDATE Doctor SET specialist ='Neurologist'
WHERE id =1005;
UPDATE Doctor SET specialist ='Pediatrician'
WHERE id =1006;
UPDATE Doctor SET specialist ='Cardiologist'
WHERE id =1007;
UPDATE Doctor SET specialist ='Urologist'
WHERE id =1009;

UPDATE doctor SET Specialist ='Gastroenterologist'
WHERE id >1009


describe doctor;

SELECT * FROM Doctor 
where match(name,specialist)
against('Neurologist' in natural language mode);



