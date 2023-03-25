select * from Doctor ;
ALTER TABLE Doctor Add Salary INT;
ALTER TABLE  Doctor Add Age INT;

CREATE TABLE DoctorAudit(Id int auto_increment primary key,
doctorid int not null,
doctorname varchar(50) not null,
doctorstatus varchar(50) not null,
doctorsalary int,
doctorAge Int,
createduser varchar(50),
createddate datetime);



select * from Doctor;
SET global Sql_safe_updates =0;
UPDATE doctor 
SET  Salary =30000
WHERE Id IN(1000,1002,1003)

delimiter $$
CREATE TRIGGER AgeCheck
 before insert on doctor For each row IF new.Age<=18
THEN SET New.age=35;
END IF; $$
delimiter ;

delimiter $$
CREATE Trigger DoctorAuditTrigger
after insert on doctor for each row 
begin 
declare vuser varchar(50);
SELECT user() INTO vuser;

INSERT INTo DoctorAudit(doctorid,doctorname,doctorstatus,doctorsalary
,doctorAge,createduser,createddate)
SELECT new.Id,new.name ,new.status,new.salary,new.Age,vuser,SYSDate();

END $$;
Delimiter ;



INSERT INTo doctor(name,hospitalid,Age,Salary,Status)
values('Babar',1,42,55000,'Available');
describe doctor;

select * from doctor;
select * from DoctorAudit

