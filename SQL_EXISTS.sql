
/*exists */
select * from doctor doc
where  exists (select * from hospital hst
				where hst.id =doc.hospitalid
                );
                



/*Any*/              
 select * from doctor doc
where  hospitalid = ANY (select id from hospital hst);       

/*ALL*/
select * from doctor doc
where  hospitalid = ALL (select distinct id from hospital hst);           
                
/* not exists */
select * from doctor doc
where not exists (select * from hospital hst
				where hst.id =doc.hospitalid
                );
                
 /* temporary table */               
create temporary table doctorinfo(doctorname varchar(50),
hospitalname varchar(150), location varchar(50));
INSERT INTo doctorinfo(doctorname,hospitalname,location)
values('Suresh','MGM','Adayar'),
	  ('Rajesh','MGM','Adayar');
      
INSERT INTo doctorinfo(doctorname,hospitalname,location)
values('Rajesh','Goutham Hospital','Guindy');
      
/* not exists  in insert statement*/
INSERT INTo Hospital(name,location)
SELECT distinct hospitalname,location  FRom doctorInfo tmp
where not exists(select * from  Hospital hsp
					where hsp.name =tmp.hospitalname
                    and hsp.location= tmp.location);
                    
                    
INSERT INTO doctor(hospitalid, name)
SELECT  hsp.id,doctorname
FROM  doctorInfo tmp
INNER JOIN Hospital hsp on hsp.name =tmp.hospitalname
and hsp.Location =tmp.Location
where not exists(select * from doctor dct 
				where dct.hospitalid= hsp.id
                and dct.name=tmp.doctorname);
